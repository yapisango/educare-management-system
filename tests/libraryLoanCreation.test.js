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

    // Create the loan through the API.
    const response = await fetch(
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

    if (!response.ok) {
        throw new Error(
            `HTTP request failed with status ${response.status}`
        );
    }

    const body = await response.json();

    if (body.success !== true) {
        throw new Error("API response success flag is not true");
    }

    if (!body.data || !body.data.id) {
        throw new Error("Created loan is missing an id");
    }

    createdLoanId = Number(body.data.id);

    if (body.data.status !== "BORROWED") {
        throw new Error(
            `Expected created loan status BORROWED, but received ${body.data.status}`
        );
    }

    if (Number(body.data.book_copy_id) !== createdCopyId) {
        throw new Error(
            `Expected book_copy_id ${createdCopyId}, but received ${body.data.book_copy_id}`
        );
    }

    if (Number(body.data.library_member_id) !== memberId) {
        throw new Error(
            `Expected library_member_id ${memberId}, but received ${body.data.library_member_id}`
        );
    }

    // Verify the physical copy was marked ON_LOAN.
    const copyStatusResult = await pool.query(`
        SELECT status
        FROM public.book_copies
        WHERE id = $1;
    `, [createdCopyId]);

    if (copyStatusResult.rows.length === 0) {
        throw new Error("Test book copy could not be found after loan creation.");
    }

    if (copyStatusResult.rows[0].status !== "ON_LOAN") {
        throw new Error(
            `Expected book copy status ON_LOAN, but received ${copyStatusResult.rows[0].status}`
        );
    }

    console.log("Library loan creation API test passed");
    console.log(`Created loan ID: ${createdLoanId}`);
    console.log(`Book copy: ${createdCopyId}`);
    console.log(`Library member: ${memberId}`);
    console.log(`Loan status: ${body.data.status}`);
    console.log(`Copy status: ${copyStatusResult.rows[0].status}`);
} finally {
    // Clean up only the loan created by this test.
    if (createdLoanId !== null) {
        await pool.query(`
            DELETE FROM public.library_loans
            WHERE id = $1;
        `, [createdLoanId]);
    }

    // Restore only the book copy used by this test.
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
