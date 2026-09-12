import pool from "../config/database.js";

let createdLoanId = null;
let createdCopyId = null;

try {
    // Find an available book copy.
    const copyResult = await pool.query(`
        SELECT id
        FROM public.book_copies
        WHERE school_id = 1
          AND is_active = TRUE
          AND status = 'AVAILABLE'
        ORDER BY id
        LIMIT 1;
    `);

    if (copyResult.rows.length === 0) {
        throw new Error("No available book copy found for test.");
    }

    createdCopyId = Number(copyResult.rows[0].id);

    // Find an active learner library member.
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
        throw new Error("No active learner library member found for test.");
    }

    const memberId = Number(memberResult.rows[0].id);

    // Create a temporary loan through the API.
    const createResponse = await fetch(
        "http://localhost:8000/api/v1/library/loans",
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                book_copy_id: createdCopyId,
                library_member_id: memberId,
                due_date: "2026-10-12",
                issued_by: 1
            })
        }
    );

    if (!createResponse.ok) {
        throw new Error(
            `Loan creation request failed with status ${createResponse.status}`
        );
    }

    const createBody = await createResponse.json();

    if (createBody.success !== true) {
        throw new Error("Loan creation API did not return success.");
    }

    if (!createBody.data || !createBody.data.id) {
        throw new Error("Created loan is missing an id.");
    }

    createdLoanId = Number(createBody.data.id);

    if (createBody.data.status !== "BORROWED") {
        throw new Error(
            `Expected created loan status BORROWED, but received ${createBody.data.status}`
        );
    }

    // Return the temporary loan through the API.
    const returnResponse = await fetch(
        `http://localhost:8000/api/v1/library/loans/${createdLoanId}/return`,
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

    if (!returnResponse.ok) {
        throw new Error(
            `Loan return request failed with status ${returnResponse.status}`
        );
    }

    const returnBody = await returnResponse.json();

    if (returnBody.success !== true) {
        throw new Error("Loan return API did not return success.");
    }

    if (!returnBody.data) {
        throw new Error("Returned loan data is missing.");
    }

    if (Number(returnBody.data.id) !== createdLoanId) {
        throw new Error(
            `Expected returned loan ID ${createdLoanId}, but received ${returnBody.data.id}`
        );
    }

    if (returnBody.data.status !== "RETURNED") {
        throw new Error(
            `Expected returned loan status RETURNED, but received ${returnBody.data.status}`
        );
    }

    if (!returnBody.data.returned_date) {
        throw new Error("Returned loan is missing returned_date.");
    }

    if (Number(returnBody.data.returned_to) !== 1) {
        throw new Error(
            `Expected returned_to 1, but received ${returnBody.data.returned_to}`
        );
    }

    // Verify the physical copy was made available again.
    const copyStatusResult = await pool.query(`
        SELECT status
        FROM public.book_copies
        WHERE id = $1;
    `, [createdCopyId]);

    if (copyStatusResult.rows.length === 0) {
        throw new Error("Test book copy could not be found after return.");
    }

    if (copyStatusResult.rows[0].status !== "AVAILABLE") {
        throw new Error(
            `Expected book copy status AVAILABLE, but received ${copyStatusResult.rows[0].status}`
        );
    }

        // Attempt to return the same loan a second time.
    const secondReturnResponse = await fetch(
        `http://localhost:8000/api/v1/library/loans/${createdLoanId}/return`,
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

    if (secondReturnResponse.status !== 400) {
        throw new Error(
            `Expected second return request to fail with status 400, but received ${secondReturnResponse.status}`
        );
    }

    const secondReturnBody = await secondReturnResponse.json();

    if (
        secondReturnBody.message !==
        "Library loan has already been returned."
    ) {
        throw new Error(
            `Unexpected duplicate return message: ${secondReturnBody.message}`
        );
    }

    console.log("Duplicate return protection passed");
    console.log("Library loan return API test passed");
    console.log(`Created loan ID: ${createdLoanId}`);
    console.log(`Book copy: ${createdCopyId}`);
    console.log(`Library member: ${memberId}`);
    console.log(`Loan status: ${returnBody.data.status}`);
    console.log(`Returned to user: ${returnBody.data.returned_to}`);
    console.log(`Copy status: ${copyStatusResult.rows[0].status}`);
} finally {
    // Clean up only the temporary loan created by this test.
    if (createdLoanId !== null) {
        await pool.query(`
            DELETE FROM public.library_loans
            WHERE id = $1;
        `, [createdLoanId]);
    }

    // Restore only the test book copy if no active loan remains.
    if (createdCopyId !== null) {
        await pool.query(`
            UPDATE public.book_copies
            SET
                status = 'AVAILABLE',
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
        `, [createdCopyId]);
    }

    await pool.end();
}
