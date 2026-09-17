import pool from "../config/database.js";

const BASE_URL = "http://localhost:8000/api/v1/library";

let testFineId = null;

const cleanup = async () => {
    if (testFineId !== null) {
        await pool.query(
            `
            DELETE FROM public.library_fines
            WHERE id = $1;
            `,
            [testFineId]
        );
    }
};

try {
    console.log("Starting Library fine lifecycle API test...");

    // ---------------------------------------------------------
    // Step 1: Find an active loan without an existing active fine.
    // ---------------------------------------------------------

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
        throw new Error("No suitable loan found for fine lifecycle test.");
    }

    const loan = loanResult.rows[0];

    // ---------------------------------------------------------
    // Step 2: Create temporary R10 fine.
    // ---------------------------------------------------------

    const createResponse = await fetch(`${BASE_URL}/fines`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            loan_id: loan.loan_id,
            fine_type: "OTHER",
            amount: 10.00,
            description: "Automated library fine lifecycle test",
            created_by: 1
        })
    });

    const createData = await createResponse.json();

    if (
        createResponse.status !== 201 ||
        createData.success !== true
    ) {
        throw new Error(
            `Fine creation failed: ${JSON.stringify(createData)}`
        );
    }

    testFineId = Number(createData.data.id);

    if (createData.data.status !== "OUTSTANDING") {
        throw new Error(
            `Expected OUTSTANDING status, received ${createData.data.status}`
        );
    }

    if (Number(createData.data.amount) !== 10) {
        throw new Error(
            `Expected fine amount R10.00, received ${createData.data.amount}`
        );
    }

    if (Number(createData.data.amount_paid) !== 0) {
        throw new Error(
            `Expected initial amount_paid R0.00, received ${createData.data.amount_paid}`
        );
    }

    console.log("Step 1: Fine creation PASSED");

    // ---------------------------------------------------------
    // Step 3: Make partial payment of R4.
    // ---------------------------------------------------------

    const partialResponse = await fetch(
        `${BASE_URL}/fines/${testFineId}/pay`,
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

    if (
        partialResponse.status !== 200 ||
        partialData.success !== true
    ) {
        throw new Error(
            `Partial payment failed: ${JSON.stringify(partialData)}`
        );
    }

    if (partialData.data.status !== "PARTIALLY_PAID") {
        throw new Error(
            `Expected PARTIALLY_PAID status, received ${partialData.data.status}`
        );
    }

    if (Number(partialData.data.amount_paid) !== 4) {
        throw new Error(
            `Expected amount_paid R4.00, received ${partialData.data.amount_paid}`
        );
    }

    if (partialData.data.paid_date !== null) {
        throw new Error(
            "paid_date should remain NULL after partial payment."
        );
    }

    console.log("Step 2: Partial payment PASSED");

    // ---------------------------------------------------------
    // Step 4: Complete remaining R6 payment.
    // ---------------------------------------------------------

    const finalResponse = await fetch(
        `${BASE_URL}/fines/${testFineId}/pay`,
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

    if (
        finalResponse.status !== 200 ||
        finalData.success !== true
    ) {
        throw new Error(
            `Final payment failed: ${JSON.stringify(finalData)}`
        );
    }

    if (finalData.data.status !== "PAID") {
        throw new Error(
            `Expected PAID status, received ${finalData.data.status}`
        );
    }

    if (Number(finalData.data.amount_paid) !== 10) {
        throw new Error(
            `Expected amount_paid R10.00, received ${finalData.data.amount_paid}`
        );
    }

    if (!finalData.data.paid_date) {
        throw new Error("paid_date should be set after final payment.");
    }

    console.log("Step 3: Final payment PASSED");

    // ---------------------------------------------------------
    // Step 5: Verify final database state.
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
            issued_date,
            paid_date,
            updated_by,
            description
        FROM public.library_fines
        WHERE id = $1;
    `, [testFineId]);

    if (databaseResult.rows.length !== 1) {
        throw new Error(
            "Temporary fine was not found in the database."
        );
    }

    const fine = databaseResult.rows[0];

    if (Number(fine.loan_id) !== Number(loan.loan_id)) {
        throw new Error(
            "Database loan_id does not match the test loan."
        );
    }

    if (
        Number(fine.library_member_id) !==
        Number(loan.library_member_id)
    ) {
        throw new Error(
            "Database library_member_id does not match the test loan."
        );
    }

    if (fine.fine_type !== "OTHER") {
        throw new Error(
            `Expected fine_type OTHER, received ${fine.fine_type}`
        );
    }

    if (Number(fine.amount) !== 10) {
        throw new Error(
            `Expected database amount R10.00, received ${fine.amount}`
        );
    }

    if (Number(fine.amount_paid) !== 10) {
        throw new Error(
            `Expected database amount_paid R10.00, received ${fine.amount_paid}`
        );
    }

    if (fine.status !== "PAID") {
        throw new Error(
            `Expected database status PAID, received ${fine.status}`
        );
    }

    if (!fine.issued_date) {
        throw new Error("Database issued_date is NULL.");
    }

    if (!fine.paid_date) {
        throw new Error("Database paid_date is NULL.");
    }

    if (Number(fine.updated_by) !== 1) {
        throw new Error(
            `Expected updated_by 1, received ${fine.updated_by}`
        );
    }

    console.log("Step 4: Final database verification PASSED");

    // ---------------------------------------------------------
    // Step 6: Clean up temporary fine.
    // ---------------------------------------------------------

    await cleanup();

    const cleanupResult = await pool.query(`
        SELECT COUNT(*) AS fine_count
        FROM public.library_fines
        WHERE id = $1;
    `, [testFineId]);

    if (Number(cleanupResult.rows[0].fine_count) !== 0) {
        throw new Error("Temporary fine cleanup failed.");
    }

    console.log("Step 5: Cleanup PASSED");

    console.log("");
    console.log("Library fine lifecycle API test passed");
    console.log(`Created temporary fine ID: ${testFineId}`);
    console.log(`Loan ID: ${loan.loan_id}`);
    console.log(`Library member ID: ${loan.library_member_id}`);
    console.log("Lifecycle: CREATE -> PARTIAL PAYMENT -> FINAL PAYMENT");
    console.log("Initial fine: R10.00");
    console.log("Partial payment: R4.00");
    console.log("Final payment: R6.00");
    console.log("Final status: PAID");
} catch (error) {
    console.error(
        "Library fine lifecycle API test failed:",
        error
    );

    process.exitCode = 1;
} finally {
    try {
        await cleanup();
    } catch (cleanupError) {
        console.error(
            "Fine lifecycle test cleanup failed:",
            cleanupError
        );
        process.exitCode = 1;
    }

    await pool.end();
}
