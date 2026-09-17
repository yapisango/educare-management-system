import pool from "../config/database.js";

const BASE_URL = "http://localhost:8000/api/v1/library";

let testLoanId = null;
let testBookCopyId = null;

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
            WHERE id = $1;
            `,
            [testBookCopyId]
        );
    }
};

try {
    // Find an available book copy.
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
        throw new Error("No available book copy found for renewal test.");
    }

    testBookCopyId = copyResult.rows[0].id;

    // Find an active learner library member.
    const memberResult = await pool.query(`
        SELECT id
        FROM public.library_members
        WHERE school_id = 1
          AND membership_type = 'LEARNER'
          AND status = 'ACTIVE'
          AND is_active = TRUE
        ORDER BY id
        LIMIT 1;
    `);

    if (memberResult.rows.length === 0) {
        throw new Error("No active learner library member found.");
    }

    const memberId = memberResult.rows[0].id;

    // Create temporary loan.
    const createResponse = await fetch(`${BASE_URL}/loans`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            book_copy_id: testBookCopyId,
            library_member_id: memberId,
            due_date: "2026-10-12",
            issued_by: 1
        })
    });

    const createData = await createResponse.json();

    if (!createResponse.ok || !createData.success) {
        throw new Error(
            `Temporary loan creation failed: ${JSON.stringify(createData)}`
        );
    }

    testLoanId = createData.data.id;

    // Successful renewal.
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

    if (!renewResponse.ok || !renewData.success) {
        throw new Error(
            `Loan renewal failed: ${JSON.stringify(renewData)}`
        );
    }

    const renewedDueDate = new Date(renewData.data.due_date);

    const renewedDueDateSouthAfrica = renewedDueDate.toLocaleDateString(
        "en-CA",
        { timeZone: "Africa/Johannesburg" }
    );

    if (renewedDueDateSouthAfrica !== "2026-10-26") {
        throw new Error(
            `Unexpected renewed due date: ${renewData.data.due_date}`
        );
    }

    if (renewData.data.renewal_count !== 1) {
        throw new Error(
            `Unexpected renewal count: ${renewData.data.renewal_count}`
        );
    }

    if (renewData.data.status !== "BORROWED") {
        throw new Error(
            `Unexpected loan status: ${renewData.data.status}`
        );
    }

    if (Number(renewData.data.updated_by) !== 1) {
        throw new Error(
            `Unexpected updated_by: ${renewData.data.updated_by}`
        );
    }

    // Same due date must be rejected.
    const sameDateResponse = await fetch(
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

    const sameDateData = await sameDateResponse.json();

    if (
        sameDateResponse.status !== 400 ||
        sameDateData.message !==
            "New due date must be later than the current due date."
    ) {
        throw new Error(
            `Same-date protection failed: ${JSON.stringify(sameDateData)}`
        );
    }

    // Earlier due date must be rejected.
    const earlierDateResponse = await fetch(
        `${BASE_URL}/loans/${testLoanId}/renew`,
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                new_due_date: "2026-10-20",
                updated_by: 1
            })
        }
    );

    const earlierDateData = await earlierDateResponse.json();

    if (
        earlierDateResponse.status !== 400 ||
        earlierDateData.message !==
            "New due date must be later than the current due date."
    ) {
        throw new Error(
            `Earlier-date protection failed: ${JSON.stringify(
                earlierDateData
            )}`
        );
    }

    // Invalid calendar date must be rejected.
    const invalidDateResponse = await fetch(
        `${BASE_URL}/loans/${testLoanId}/renew`,
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                new_due_date: "2026-02-30",
                updated_by: 1
            })
        }
    );

    const invalidDateData = await invalidDateResponse.json();

    if (
        invalidDateResponse.status !== 400 ||
        invalidDateData.message !== "Invalid new due date."
    ) {
        throw new Error(
            `Invalid-date protection failed: ${JSON.stringify(
                invalidDateData
            )}`
        );
    }

    // Returned loan must not be renewable.
    await pool.query(
        `
        UPDATE public.library_loans
        SET
            returned_date = CURRENT_DATE,
            status = 'RETURNED',
            returned_to = 1,
            updated_by = 1,
            updated_at = NOW()
        WHERE id = $1;
        `,
        [testLoanId]
    );

    const returnedResponse = await fetch(
        `${BASE_URL}/loans/${testLoanId}/renew`,
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                new_due_date: "2026-11-01",
                updated_by: 1
            })
        }
    );

    const returnedData = await returnedResponse.json();

    if (
        returnedResponse.status !== 400 ||
        returnedData.message !==
            "Only a borrowed library loan can be renewed."
    ) {
        throw new Error(
            `Returned-loan protection failed: ${JSON.stringify(
                returnedData
            )}`
        );
    }

    // Restore temporary loan to active state before cleanup.
    await pool.query(
        `
        UPDATE public.library_loans
        SET
            returned_date = NULL,
            status = 'BORROWED',
            returned_to = NULL
        WHERE id = $1;
        `,
        [testLoanId]
    );

    // Verify database state after successful renewal.
    const dbResult = await pool.query(
        `
        SELECT
            id,
            due_date,
            status,
            renewal_count,
            updated_by
        FROM public.library_loans
        WHERE id = $1;
        `,
        [testLoanId]
    );

    if (dbResult.rows.length !== 1) {
        throw new Error("Renewed test loan was not found in database.");
    }

    const loan = dbResult.rows[0];

    if (
        new Date(loan.due_date).toLocaleDateString(
            "en-CA",
            { timeZone: "Africa/Johannesburg" }
        ) !== "2026-10-26"
    ) {
        throw new Error(
            `Database due date mismatch: ${loan.due_date}`
        );
    }

    if (loan.status !== "BORROWED") {
        throw new Error(
            `Database status mismatch: ${loan.status}`
        );
    }

    if (loan.renewal_count !== 1) {
        throw new Error(
            `Database renewal count mismatch: ${loan.renewal_count}`
        );
    }

    if (Number(loan.updated_by) !== 1) {
        throw new Error(
            `Database updated_by mismatch: ${loan.updated_by}`
        );
    }

    console.log("Library loan renewal API test passed");
    console.log(`Created test loan ID: ${testLoanId}`);
    console.log(`Book copy ID: ${testBookCopyId}`);
    console.log(`Initial due date: 2026-10-12`);
    console.log(`Renewed due date: ${loan.due_date}`);
    console.log(`Renewal count: ${loan.renewal_count}`);
    console.log(`Same-date protection: PASSED`);
    console.log(`Earlier-date protection: PASSED`);
    console.log(`Invalid-date protection: PASSED`);
    console.log(`Returned-loan protection: PASSED`);
} catch (error) {
    console.error("Library loan renewal API test failed:", error);
    process.exitCode = 1;
} finally {
    try {
        await cleanup();
    } catch (cleanupError) {
        console.error(
            "Renewal test cleanup failed:",
            cleanupError
        );
        process.exitCode = 1;
    }

    await pool.end();
}