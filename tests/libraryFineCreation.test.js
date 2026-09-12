import pool from "../config/database.js";

const API_URL = "http://localhost:8000/api/v1/library";

const runTest = async () => {
    let createdFineId = null;

    try {
        // Find an active loan without an existing active fine.
        const loanResult = await pool.query(`
            SELECT
                l.id AS loan_id,
                l.school_id,
                l.library_member_id
            FROM public.library_loans l
            LEFT JOIN public.library_fines f
                ON f.loan_id = l.id
                AND f.is_active = TRUE
                AND f.status <> 'WAIVED'
            WHERE l.is_active = TRUE
              AND f.id IS NULL
            ORDER BY l.id
            LIMIT 1;
        `);

        if (loanResult.rows.length === 0) {
            throw new Error("No suitable loan found for fine creation test.");
        }

        const loan = loanResult.rows[0];

        // Create a temporary fine through the API.
        const response = await fetch(`${API_URL}/fines`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                loan_id: loan.loan_id,
                fine_type: "OTHER",
                amount: 10.00,
                description: "Automated library fine creation test",
                created_by: 1
            })
        });

        const responseData = await response.json();

        if (response.status !== 201) {
            throw new Error(
                `Expected HTTP 201, received ${response.status}: ${JSON.stringify(responseData)}`
            );
        }

        if (responseData.success !== true) {
            throw new Error("API did not report successful fine creation.");
        }

        if (responseData.data.fine_type !== "OTHER") {
            throw new Error("Created fine type does not match expected value.");
        }

        if (Number(responseData.data.amount) !== 10) {
            throw new Error("Created fine amount does not match expected value.");
        }

        if (responseData.data.status !== "OUTSTANDING") {
            throw new Error("Created fine status is not OUTSTANDING.");
        }

        createdFineId = responseData.data.id;

        // Verify the fine was persisted in the database.
        const databaseResult = await pool.query(`
            SELECT
                id,
                loan_id,
                library_member_id,
                fine_type,
                amount,
                amount_paid,
                status,
                description,
                created_by
            FROM public.library_fines
            WHERE id = $1;
        `, [createdFineId]);

        if (databaseResult.rows.length !== 1) {
            throw new Error("Created fine was not found in the database.");
        }

        const fine = databaseResult.rows[0];

        if (Number(fine.loan_id) !== Number(loan.loan_id)) {
            throw new Error("Stored loan_id does not match the test loan.");
        }

        if (Number(fine.library_member_id) !== Number(loan.library_member_id)) {
            throw new Error("Stored library_member_id does not match the loan.");
        }

        if (fine.fine_type !== "OTHER") {
            throw new Error("Stored fine_type does not match expected value.");
        }

        if (Number(fine.amount) !== 10) {
            throw new Error("Stored fine amount does not match expected value.");
        }

        if (Number(fine.amount_paid) !== 0) {
            throw new Error("New fine amount_paid should be zero.");
        }

        if (fine.status !== "OUTSTANDING") {
            throw new Error("Stored fine status is not OUTSTANDING.");
        }

        // Clean up only the temporary test fine.
        await pool.query(`
            DELETE FROM public.library_fines
            WHERE id = $1;
        `, [createdFineId]);

        // Verify cleanup.
        const cleanupResult = await pool.query(`
            SELECT COUNT(*) AS fine_count
            FROM public.library_fines
            WHERE id = $1;
        `, [createdFineId]);

        if (Number(cleanupResult.rows[0].fine_count) !== 0) {
            throw new Error("Test fine cleanup failed.");
        }

        console.log("Library fine creation API test passed");
        console.log(`Created fine ID: ${createdFineId}`);
        console.log(`Loan ID: ${loan.loan_id}`);
        console.log(`Library member: ${loan.library_member_id}`);
        console.log("Fine type: OTHER");
        console.log("Fine amount: R10.00");
        console.log("Fine status: OUTSTANDING");
    } catch (error) {
        // Attempt cleanup if the test failed after creating the fine.
        if (createdFineId !== null) {
            try {
                await pool.query(`
                    DELETE FROM public.library_fines
                    WHERE id = $1;
                `, [createdFineId]);
            } catch (cleanupError) {
                console.error(
                    "Test fine cleanup failed:",
                    cleanupError
                );
            }
        }

        console.error("Library fine creation API test failed:", error);
        process.exitCode = 1;
    } finally {
        await pool.end();
    }
};

runTest();