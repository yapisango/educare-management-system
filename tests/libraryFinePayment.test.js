import pool from "../config/database.js";

const API_URL = "http://localhost:8000/api/v1/library";

let createdFineId = null;

const runTest = async () => {
    try {
        // Find an active loan without an existing active fine.
        const loanResult = await pool.query(`
            SELECT
                l.id AS loan_id,
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
            throw new Error(
                "No suitable loan found for fine payment test."
            );
        }

        const loan = loanResult.rows[0];

        // Create a temporary R10 fine through the API.
        const createResponse = await fetch(`${API_URL}/fines`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                loan_id: loan.loan_id,
                fine_type: "OTHER",
                amount: 10.00,
                description: "Automated library fine payment test",
                created_by: 1
            })
        });

        const createData = await createResponse.json();

        if (createResponse.status !== 201) {
            throw new Error(
                `Fine creation failed. HTTP ${createResponse.status}: ${JSON.stringify(createData)}`
            );
        }

        if (createData.success !== true) {
            throw new Error(
                "Temporary fine was not created successfully."
            );
        }

        createdFineId = createData.data.id;

        // ---------------------------------------------------------
        // Test 1: Partial payment
        // ---------------------------------------------------------

        const partialResponse = await fetch(
            `${API_URL}/fines/${createdFineId}/pay`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    amount: 4.00,
                    updated_by: 1
                })
            }
        );

        const partialData = await partialResponse.json();

        if (partialResponse.status !== 200) {
            throw new Error(
                `Partial payment failed. HTTP ${partialResponse.status}: ${JSON.stringify(partialData)}`
            );
        }

        if (partialData.success !== true) {
            throw new Error(
                "Partial payment did not report success."
            );
        }

        if (partialData.data.status !== "PARTIALLY_PAID") {
            throw new Error(
                "Partial payment did not set status to PARTIALLY_PAID."
            );
        }

        if (Number(partialData.data.amount_paid) !== 4) {
            throw new Error(
                "Partial payment amount_paid should be R4.00."
            );
        }

        if (partialData.data.paid_date !== null) {
            throw new Error(
                "paid_date should remain NULL after a partial payment."
            );
        }

        // ---------------------------------------------------------
        // Test 2: Overpayment protection
        // ---------------------------------------------------------

        const overpaymentResponse = await fetch(
            `${API_URL}/fines/${createdFineId}/pay`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    amount: 7.00,
                    updated_by: 1
                })
            }
        );

        const overpaymentData = await overpaymentResponse.json();

        if (overpaymentResponse.status !== 400) {
            throw new Error(
                `Expected overpayment HTTP 400, received ${overpaymentResponse.status}: ${JSON.stringify(overpaymentData)}`
            );
        }

        if (
            overpaymentData.message !==
            "Payment amount exceeds the remaining fine balance of R6.00."
        ) {
            throw new Error(
                `Unexpected overpayment message: ${overpaymentData.message}`
            );
        }

        // ---------------------------------------------------------
        // Test 3: Final payment
        // ---------------------------------------------------------

        const finalResponse = await fetch(
            `${API_URL}/fines/${createdFineId}/pay`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    amount: 6.00,
                    updated_by: 1
                })
            }
        );

        const finalData = await finalResponse.json();

        if (finalResponse.status !== 200) {
            throw new Error(
                `Final payment failed. HTTP ${finalResponse.status}: ${JSON.stringify(finalData)}`
            );
        }

        if (finalData.success !== true) {
            throw new Error(
                "Final payment did not report success."
            );
        }

        if (finalData.data.status !== "PAID") {
            throw new Error(
                "Final payment did not set status to PAID."
            );
        }

        if (Number(finalData.data.amount_paid) !== 10) {
            throw new Error(
                "Final payment amount_paid should equal the full fine amount."
            );
        }

        if (!finalData.data.paid_date) {
            throw new Error(
                "paid_date should be set after full payment."
            );
        }

        // ---------------------------------------------------------
        // Test 4: Prevent payment after full payment
        // ---------------------------------------------------------

        const secondPaymentResponse = await fetch(
            `${API_URL}/fines/${createdFineId}/pay`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    amount: 1.00,
                    updated_by: 1
                })
            }
        );

        const secondPaymentData = await secondPaymentResponse.json();

        if (secondPaymentResponse.status !== 400) {
            throw new Error(
                `Expected second-payment HTTP 400, received ${secondPaymentResponse.status}: ${JSON.stringify(secondPaymentData)}`
            );
        }

        if (
            secondPaymentData.message !==
            "Library fine has already been fully paid."
        ) {
            throw new Error(
                `Unexpected second-payment message: ${secondPaymentData.message}`
            );
        }

        // ---------------------------------------------------------
        // Verify final database state before cleanup.
        // ---------------------------------------------------------

        const databaseResult = await pool.query(`
            SELECT
                id,
                loan_id,
                library_member_id,
                fine_type,
                amount,
                amount_paid,
                status,
                paid_date,
                updated_by,
                description
            FROM public.library_fines
            WHERE id = $1;
        `, [createdFineId]);

        if (databaseResult.rows.length !== 1) {
            throw new Error(
                "Temporary fine was not found in the database."
            );
        }

        const fine = databaseResult.rows[0];

        if (Number(fine.loan_id) !== Number(loan.loan_id)) {
            throw new Error(
                "Stored loan_id does not match the test loan."
            );
        }

        if (
            Number(fine.library_member_id) !==
            Number(loan.library_member_id)
        ) {
            throw new Error(
                "Stored library_member_id does not match the loan."
            );
        }

        if (Number(fine.amount) !== 10) {
            throw new Error(
                "Stored fine amount should be R10.00."
            );
        }

        if (Number(fine.amount_paid) !== 10) {
            throw new Error(
                "Stored amount_paid should be R10.00."
            );
        }

        if (fine.status !== "PAID") {
            throw new Error(
                "Stored fine status should be PAID."
            );
        }

        if (!fine.paid_date) {
            throw new Error(
                "Stored paid_date should not be NULL."
            );
        }

        if (Number(fine.updated_by) !== 1) {
            throw new Error(
                "Stored updated_by should be user 1."
            );
        }

        // ---------------------------------------------------------
        // Clean up the temporary fine.
        // ---------------------------------------------------------

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
            throw new Error(
                "Temporary fine cleanup failed."
            );
        }

        console.log("Library fine payment API test passed");
        console.log(`Created fine ID: ${createdFineId}`);
        console.log(`Loan ID: ${loan.loan_id}`);
        console.log(`Library member: ${loan.library_member_id}`);
        console.log("Initial fine amount: R10.00");
        console.log("Partial payment: R4.00");
        console.log("Remaining balance: R6.00");
        console.log("Final payment: R6.00");
        console.log("Final status: PAID");
        console.log("Overpayment protection: PASSED");
        console.log("Duplicate payment protection: PASSED");
    } catch (error) {
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

        console.error(
            "Library fine payment API test failed:",
            error
        );

        process.exitCode = 1;
    } finally {
        await pool.end();
    }
};

runTest();