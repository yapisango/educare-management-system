import pool from "../config/database.js";

const BASE_URL = "http://localhost:8000/api/v1/library";

let testLoanId = null;
let testBookCopyId = null;
let testMemberId = null;

const cleanup = async () => {
    if (testLoanId !== null) {
        await pool.query(
            `
            DELETE FROM public.library_loans
            WHERE id = $1;
            `,
            [testLoanId]
        );
    }

    if (testBookCopyId !== null) {
        await pool.query(
            `
            UPDATE public.book_copies
            SET
                status = 'AVAILABLE',
                updated_by = 1,
                updated_at = NOW()
            WHERE id = $1
              AND NOT EXISTS (
                  SELECT 1
                  FROM public.library_loans
                  WHERE book_copy_id = $1
                    AND is_active = TRUE
                    AND returned_date IS NULL
                    AND status IN ('BORROWED', 'OVERDUE', 'LOST')
              );
            `,
            [testBookCopyId]
        );
    }
};

try {
    console.log("Starting Library loan lifecycle API test...");

    // ---------------------------------------------------------
    // Step 1: Find an available book copy.
    // ---------------------------------------------------------

    const copyResult = await pool.query(`
        SELECT id
        FROM public.book_copies
        WHERE school_id = 1
          AND status = 'AVAILABLE'
          AND is_active = TRUE
        ORDER BY id
        LIMIT 1;
    `);

    if (copyResult.rows.length === 0) {
        throw new Error("No available book copy found.");
    }

    testBookCopyId = Number(copyResult.rows[0].id);

    // ---------------------------------------------------------
    // Step 2: Find an active learner library member.
    // ---------------------------------------------------------

    const memberResult = await pool.query(`
        SELECT id
        FROM public.library_members
        WHERE school_id = 1
          AND membership_type = 'LEARNER'
          AND status = 'ACTIVE'
          AND is_active = TRUE
          AND (
              expiry_date IS NULL
              OR expiry_date >= CURRENT_DATE
          )
        ORDER BY id
        LIMIT 1;
    `);

    if (memberResult.rows.length === 0) {
        throw new Error("No active learner library member found.");
    }

    testMemberId = Number(memberResult.rows[0].id);

    // ---------------------------------------------------------
    // Step 3: Create temporary loan.
    // ---------------------------------------------------------

    const createResponse = await fetch(`${BASE_URL}/loans`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            book_copy_id: testBookCopyId,
            library_member_id: testMemberId,
            due_date: "2026-10-12",
            issued_by: 1
        })
    });

    const createData = await createResponse.json();

    if (
        createResponse.status !== 201 ||
        createData.success !== true
    ) {
        throw new Error(
            `Loan creation failed: ${JSON.stringify(createData)}`
        );
    }

    testLoanId = Number(createData.data.id);

    if (createData.data.status !== "BORROWED") {
        throw new Error(
            `Expected BORROWED status, received ${createData.data.status}`
        );
    }

    if (Number(createData.data.book_copy_id) !== testBookCopyId) {
        throw new Error("Created loan has incorrect book_copy_id.");
    }

    if (Number(createData.data.library_member_id) !== testMemberId) {
        throw new Error("Created loan has incorrect library_member_id.");
    }

    // Verify physical copy is ON_LOAN.
    const loanCopyResult = await pool.query(`
        SELECT status
        FROM public.book_copies
        WHERE id = $1;
    `, [testBookCopyId]);

    if (loanCopyResult.rows[0].status !== "ON_LOAN") {
        throw new Error(
            `Expected copy status ON_LOAN, received ${loanCopyResult.rows[0].status}`
        );
    }

    console.log("Step 1: Loan creation PASSED");

    // ---------------------------------------------------------
    // Step 4: Renew the loan.
    // ---------------------------------------------------------

    const renewResponse = await fetch(
        `${BASE_URL}/loans/${testLoanId}/renew`,
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                new_due_date: "2026-10-26",
                updated_by: 1
            })
        }
    );

    const renewData = await renewResponse.json();

    if (
        renewResponse.status !== 200 ||
        renewData.success !== true
    ) {
        throw new Error(
            `Loan renewal failed: ${JSON.stringify(renewData)}`
        );
    }

    const renewedDueDate = new Date(renewData.data.due_date)
        .toLocaleDateString(
            "en-CA",
            { timeZone: "Africa/Johannesburg" }
        );

    if (renewedDueDate !== "2026-10-26") {
        throw new Error(
            `Expected renewed due date 2026-10-26, received ${renewedDueDate}`
        );
    }

    if (renewData.data.renewal_count !== 1) {
        throw new Error(
            `Expected renewal_count 1, received ${renewData.data.renewal_count}`
        );
    }

    if (renewData.data.status !== "BORROWED") {
        throw new Error(
            `Expected BORROWED status after renewal, received ${renewData.data.status}`
        );
    }

    if (Number(renewData.data.updated_by) !== 1) {
        throw new Error(
            `Expected updated_by 1, received ${renewData.data.updated_by}`
        );
    }

    console.log("Step 2: Loan renewal PASSED");

    // ---------------------------------------------------------
    // Step 5: Return the renewed loan.
    // ---------------------------------------------------------

    const returnResponse = await fetch(
        `${BASE_URL}/loans/${testLoanId}/return`,
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                returned_to: 1
            })
        }
    );

    const returnData = await returnResponse.json();

    if (
        returnResponse.status !== 200 ||
        returnData.success !== true
    ) {
        throw new Error(
            `Loan return failed: ${JSON.stringify(returnData)}`
        );
    }

    if (returnData.data.status !== "RETURNED") {
        throw new Error(
            `Expected RETURNED status, received ${returnData.data.status}`
        );
    }

    if (!returnData.data.returned_date) {
        throw new Error("Returned loan has no returned_date.");
    }

    if (Number(returnData.data.returned_to) !== 1) {
        throw new Error(
            `Expected returned_to 1, received ${returnData.data.returned_to}`
        );
    }

    // Verify physical copy is AVAILABLE again.
    const returnedCopyResult = await pool.query(`
        SELECT status
        FROM public.book_copies
        WHERE id = $1;
    `, [testBookCopyId]);

    if (returnedCopyResult.rows[0].status !== "AVAILABLE") {
        throw new Error(
            `Expected copy status AVAILABLE, received ${returnedCopyResult.rows[0].status}`
        );
    }

    console.log("Step 3: Loan return PASSED");

    // ---------------------------------------------------------
    // Step 6: Verify final database state.
    // ---------------------------------------------------------

    const dbResult = await pool.query(`
        SELECT
            id,
            book_copy_id,
            library_member_id,
            due_date,
            returned_date,
            status,
            renewal_count,
            issued_by,
            returned_to,
            updated_by
        FROM public.library_loans
        WHERE id = $1;
    `, [testLoanId]);

    if (dbResult.rows.length !== 1) {
        throw new Error("Test loan was not found in database.");
    }

    const loan = dbResult.rows[0];

    const dbDueDate = new Date(loan.due_date)
        .toLocaleDateString(
            "en-CA",
            { timeZone: "Africa/Johannesburg" }
        );

    if (dbDueDate !== "2026-10-26") {
        throw new Error(
            `Database due date mismatch: ${dbDueDate}`
        );
    }

    if (loan.status !== "RETURNED") {
        throw new Error(
            `Database status mismatch: ${loan.status}`
        );
    }

    if (!loan.returned_date) {
        throw new Error("Database returned_date is NULL.");
    }

    if (loan.renewal_count !== 1) {
        throw new Error(
            `Database renewal_count mismatch: ${loan.renewal_count}`
        );
    }

    if (Number(loan.issued_by) !== 1) {
        throw new Error(
            `Database issued_by mismatch: ${loan.issued_by}`
        );
    }

    if (Number(loan.returned_to) !== 1) {
        throw new Error(
            `Database returned_to mismatch: ${loan.returned_to}`
        );
    }

    console.log("Step 4: Final database verification PASSED");

    console.log("");
    console.log("Library loan lifecycle API test passed");
    console.log(`Created temporary loan ID: ${testLoanId}`);
    console.log(`Book copy ID: ${testBookCopyId}`);
    console.log(`Library member ID: ${testMemberId}`);
    console.log("Lifecycle: CREATE -> RENEW -> RETURN");
    console.log("Final loan status: RETURNED");
    console.log("Final copy status: AVAILABLE");
    console.log("Renewal count: 1");
} catch (error) {
    console.error(
        "Library loan lifecycle API test failed:",
        error
    );

    process.exitCode = 1;
} finally {
    try {
        await cleanup();
    } catch (cleanupError) {
        console.error(
            "Lifecycle test cleanup failed:",
            cleanupError
        );
        process.exitCode = 1;
    }

    await pool.end();
}
