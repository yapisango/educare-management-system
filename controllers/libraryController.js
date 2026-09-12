import pool from "../config/database.js";

export const getBooks = async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                b.id,
                b.public_id,
                b.isbn,
                b.title,
                b.author,
                b.publisher,
                b.publication_year,
                b.edition,
                b.category,
                b.language,
                b.description,
                s.subject_name AS subject_name,
                g.grade_name AS grade_name
            FROM public.books b
            LEFT JOIN public.subjects s
                ON s.id = b.subject_id
            LEFT JOIN public.grades g
                ON g.id = b.grade_id
            WHERE b.is_active = TRUE
            ORDER BY b.id;
        `);

        res.status(200).json({
            success: true,
            message: "Books retrieved successfully.",
            data: result.rows
        });
    } catch (error) {
        console.error("Failed to retrieve books:", error);

        res.status(500).json({
            success: false,
            message: "Failed to retrieve books.",
            errors: []
        });
    }
};

export const getBookById = async (req, res) => {
    try {
        const { id } = req.params;

        const result = await pool.query(`
            SELECT
                b.id,
                b.public_id,
                b.isbn,
                b.title,
                b.author,
                b.publisher,
                b.publication_year,
                b.edition,
                b.category,
                b.language,
                b.description,
                s.subject_name AS subject_name,
                g.grade_name AS grade_name
            FROM public.books b
            LEFT JOIN public.subjects s
                ON s.id = b.subject_id
            LEFT JOIN public.grades g
                ON g.id = b.grade_id
            WHERE b.id = $1
              AND b.is_active = TRUE;
        `, [id]);

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Book not found.",
                errors: []
            });
        }

        res.status(200).json({
            success: true,
            message: "Book retrieved successfully.",
            data: result.rows[0]
        });
    } catch (error) {
        console.error("Failed to retrieve book:", error);

        res.status(500).json({
            success: false,
            message: "Failed to retrieve book.",
            errors: []
        });
    }
};

export const getMembers = async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                lm.id,
                lm.public_id,
                lm.membership_number,
                lm.membership_type,
                lm.membership_date,
                lm.expiry_date,
                lm.max_books,
                lm.status,

                u.id AS user_id,
                u.public_id AS user_public_id,
                u.first_name,
                u.last_name,
                u.email,
                u.phone,

                l.id AS learner_id,
                l.learner_number,

                e.id AS employee_id,
                e.employee_number,

                g.id AS guardian_id,
                g.relationship_to_learner

            FROM public.library_members lm

            INNER JOIN public.users u
                ON u.id = lm.user_id

            LEFT JOIN public.learners l
                ON l.id = lm.learner_id

            LEFT JOIN public.employees e
                ON e.id = lm.employee_id

            LEFT JOIN public.guardians g
                ON g.id = lm.guardian_id

            WHERE lm.is_active = TRUE
            ORDER BY lm.id;
        `);

        res.status(200).json({
            success: true,
            message: "Library members retrieved successfully.",
            data: result.rows
        });
    } catch (error) {
        console.error("Failed to retrieve library members:", error);

        res.status(500).json({
            success: false,
            message: "Failed to retrieve library members.",
            errors: []
        });
    }
};

export const getLoans = async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                ll.id,
                ll.public_id,
                ll.school_id,
                ll.loan_date,
                ll.due_date,
                ll.returned_date,
                ll.status,
                ll.renewal_count,
                ll.notes,

                bc.id AS book_copy_id,
                bc.public_id AS book_copy_public_id,
                bc.copy_number,
                bc.barcode,
                bc.condition AS copy_condition,
                bc.status AS copy_status,
                bc.shelf_location,

                b.id AS book_id,
                b.public_id AS book_public_id,
                b.isbn,
                b.title,
                b.author,

                lm.id AS library_member_id,
                lm.public_id AS library_member_public_id,
                lm.membership_number,
                lm.membership_type,

                member_user.id AS member_user_id,
                member_user.first_name AS member_first_name,
                member_user.last_name AS member_last_name,
                member_user.email AS member_email,

                issued_user.id AS issued_by_user_id,
                issued_user.first_name AS issued_by_first_name,
                issued_user.last_name AS issued_by_last_name,

                returned_user.id AS returned_to_user_id,
                returned_user.first_name AS returned_to_first_name,
                returned_user.last_name AS returned_to_last_name

            FROM public.library_loans ll

            INNER JOIN public.book_copies bc
                ON bc.id = ll.book_copy_id

            INNER JOIN public.books b
                ON b.id = bc.book_id

            INNER JOIN public.library_members lm
                ON lm.id = ll.library_member_id

            INNER JOIN public.users member_user
                ON member_user.id = lm.user_id

            LEFT JOIN public.users issued_user
                ON issued_user.id = ll.issued_by

            LEFT JOIN public.users returned_user
                ON returned_user.id = ll.returned_to

            WHERE ll.is_active = TRUE

            ORDER BY ll.id;
        `);

        res.status(200).json({
            success: true,
            message: "Library loans retrieved successfully.",
            data: result.rows
        });
    } catch (error) {
        console.error("Failed to retrieve library loans:", error);

        res.status(500).json({
            success: false,
            message: "Failed to retrieve library loans.",
            errors: []
        });
    }
};


export const createLoan = async (req, res) => {
    const client = await pool.connect();

    try {
        const {
            book_copy_id,
            library_member_id,
            due_date,
            issued_by
        } = req.body;

        if (!book_copy_id || !library_member_id || !due_date) {
            return res.status(400).json({
                success: false,
                message: "book_copy_id, library_member_id and due_date are required.",
                errors: []
            });
        }

        await client.query("BEGIN");

        // Lock and validate the library member.
        const memberResult = await client.query(`
            SELECT
                id,
                school_id,
                max_books,
                status,
                expiry_date
            FROM public.library_members
            WHERE id = $1
              AND is_active = TRUE
            FOR UPDATE;
        `, [library_member_id]);

        if (memberResult.rows.length === 0) {
            await client.query("ROLLBACK");

            return res.status(404).json({
                success: false,
                message: "Library member not found.",
                errors: []
            });
        }

        const member = memberResult.rows[0];

        if (member.status !== "ACTIVE") {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Library member is not active.",
                errors: []
            });
        }

        if (
            member.expiry_date &&
            new Date(member.expiry_date) < new Date()
        ) {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Library membership has expired.",
                errors: []
            });
        }

        // Check the member's current active loan count.
        const loanCountResult = await client.query(`
            SELECT COUNT(*)::integer AS active_loans
            FROM public.library_loans
            WHERE library_member_id = $1
              AND is_active = TRUE
              AND returned_date IS NULL
              AND status IN ('BORROWED', 'OVERDUE', 'LOST');
        `, [library_member_id]);

        const activeLoans = loanCountResult.rows[0].active_loans;

        if (activeLoans >= member.max_books) {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Library member has reached the maximum number of active loans.",
                errors: []
            });
        }

        // Lock and validate the physical book copy.
        const copyResult = await client.query(`
            SELECT
                id,
                book_id,
                school_id,
                status,
                is_active
            FROM public.book_copies
            WHERE id = $1
              AND is_active = TRUE
            FOR UPDATE;
        `, [book_copy_id]);

        if (copyResult.rows.length === 0) {
            await client.query("ROLLBACK");

            return res.status(404).json({
                success: false,
                message: "Book copy not found.",
                errors: []
            });
        }

        const copy = copyResult.rows[0];

        if (copy.school_id !== member.school_id) {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Book copy and library member belong to different schools.",
                errors: []
            });
        }

        if (copy.status !== "AVAILABLE") {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Book copy is not available for loan.",
                errors: []
            });
        }

        // Create the loan.
        const loanResult = await client.query(`
            INSERT INTO public.library_loans (
                school_id,
                book_copy_id,
                library_member_id,
                due_date,
                status,
                issued_by
            )
            VALUES ($1, $2, $3, $4, 'BORROWED', $5)
            RETURNING
                id,
                public_id,
                school_id,
                book_copy_id,
                library_member_id,
                loan_date,
                due_date,
                status,
                renewal_count,
                issued_by;
        `, [
            member.school_id,
            book_copy_id,
            library_member_id,
            due_date,
            issued_by || null
        ]);

        // Mark the physical copy as being on loan.
        await client.query(`
            UPDATE public.book_copies
            SET
                status = 'ON_LOAN',
                updated_at = NOW()
            WHERE id = $1;
        `, [book_copy_id]);

        await client.query("COMMIT");

        res.status(201).json({
            success: true,
            message: "Book loan created successfully.",
            data: loanResult.rows[0]
        });
    } catch (error) {
        try {
            await client.query("ROLLBACK");
        } catch (rollbackError) {
            console.error("Loan transaction rollback failed:", rollbackError);
        }

        console.error("Failed to create library loan:", error);

        res.status(500).json({
            success: false,
            message: "Failed to create library loan.",
            errors: []
        });
    } finally {
        client.release();
    }
};

export const returnLoan = async (req, res) => {
    const client = await pool.connect();

    try {
        const { id } = req.params;
        const { returned_to } = req.body;

        await client.query("BEGIN");

        // Lock and find the active loan.
        const loanResult = await client.query(`
            SELECT
                id,
                school_id,
                book_copy_id,
                library_member_id,
                loan_date,
                due_date,
                returned_date,
                status
            FROM public.library_loans
            WHERE id = $1
              AND is_active = TRUE
            FOR UPDATE;
        `, [id]);

        if (loanResult.rows.length === 0) {
            await client.query("ROLLBACK");

            return res.status(404).json({
                success: false,
                message: "Library loan not found.",
                errors: []
            });
        }

        const loan = loanResult.rows[0];

        // A loan that already has a returned date cannot be returned again.
        if (loan.returned_date !== null || loan.status === "RETURNED") {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Library loan has already been returned.",
                errors: []
            });
        }

        // Lock the physical book copy.
        const copyResult = await client.query(`
            SELECT
                id,
                school_id,
                status,
                is_active
            FROM public.book_copies
            WHERE id = $1
              AND is_active = TRUE
            FOR UPDATE;
        `, [loan.book_copy_id]);

        if (copyResult.rows.length === 0) {
            await client.query("ROLLBACK");

            return res.status(404).json({
                success: false,
                message: "Book copy associated with this loan was not found.",
                errors: []
            });
        }

        const copy = copyResult.rows[0];

        if (copy.school_id !== loan.school_id) {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Book copy and loan belong to different schools.",
                errors: []
            });
        }

        // Return the loan and record the return user.
        const returnedLoanResult = await client.query(`
            UPDATE public.library_loans
            SET
                returned_date = CURRENT_DATE,
                status = 'RETURNED',
                returned_to = $2,
                updated_at = NOW()
            WHERE id = $1
            RETURNING
                id,
                public_id,
                school_id,
                book_copy_id,
                library_member_id,
                loan_date,
                due_date,
                returned_date,
                status,
                renewal_count,
                issued_by,
                returned_to;
        `, [id, returned_to || null]);

        // Make the physical copy available again.
        await client.query(`
            UPDATE public.book_copies
            SET
                status = 'AVAILABLE',
                updated_at = NOW()
            WHERE id = $1;
        `, [loan.book_copy_id]);

        await client.query("COMMIT");

        res.status(200).json({
            success: true,
            message: "Book loan returned successfully.",
            data: returnedLoanResult.rows[0]
        });
    } catch (error) {
        try {
            await client.query("ROLLBACK");
        } catch (rollbackError) {
            console.error("Loan return transaction rollback failed:", rollbackError);
        }

        console.error("Failed to return library loan:", error);

        res.status(500).json({
            success: false,
            message: "Failed to return library loan.",
            errors: []
        });
    } finally {
        client.release();
    }
};

export const getFines = async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                lf.id,
                lf.public_id,
                lf.school_id,
                lf.fine_type,
                lf.amount,
                lf.amount_paid,
                lf.issued_date,
                lf.paid_date,
                lf.status,
                lf.description,

                ll.id AS loan_id,
                ll.public_id AS loan_public_id,
                ll.loan_date,
                ll.due_date,
                ll.returned_date,
                ll.status AS loan_status,

                bc.id AS book_copy_id,
                bc.public_id AS book_copy_public_id,
                bc.copy_number,
                bc.barcode,

                b.id AS book_id,
                b.public_id AS book_public_id,
                b.isbn,
                b.title,
                b.author,

                lm.id AS library_member_id,
                lm.public_id AS library_member_public_id,
                lm.membership_number,
                lm.membership_type,

                member_user.id AS member_user_id,
                member_user.first_name AS member_first_name,
                member_user.last_name AS member_last_name,
                member_user.email AS member_email

            FROM public.library_fines lf

            INNER JOIN public.library_loans ll
                ON ll.id = lf.loan_id

            INNER JOIN public.book_copies bc
                ON bc.id = ll.book_copy_id

            INNER JOIN public.books b
                ON b.id = bc.book_id

            INNER JOIN public.library_members lm
                ON lm.id = lf.library_member_id

            INNER JOIN public.users member_user
                ON member_user.id = lm.user_id

            WHERE lf.is_active = TRUE

            ORDER BY lf.id;
        `);

        res.status(200).json({
            success: true,
            message: "Library fines retrieved successfully.",
            data: result.rows
        });
    } catch (error) {
        console.error("Failed to retrieve library fines:", error);

        res.status(500).json({
            success: false,
            message: "Failed to retrieve library fines.",
            errors: []
        });
    }
};

export const createFine = async (req, res) => {
    const client = await pool.connect();

    try {
        const {
            loan_id,
            fine_type,
            amount,
            description,
            created_by
        } = req.body;

        if (!loan_id || !fine_type || amount === undefined) {
            return res.status(400).json({
                success: false,
                message: "loan_id, fine_type and amount are required.",
                errors: []
            });
        }

        const allowedFineTypes = [
            "OVERDUE",
            "LOST_BOOK",
            "DAMAGED_BOOK",
            "OTHER"
        ];

        if (!allowedFineTypes.includes(fine_type)) {
            return res.status(400).json({
                success: false,
                message: "Invalid fine type.",
                errors: []
            });
        }

        const numericAmount = Number(amount);

        if (!Number.isFinite(numericAmount) || numericAmount <= 0) {
            return res.status(400).json({
                success: false,
                message: "Fine amount must be greater than zero.",
                errors: []
            });
        }

        await client.query("BEGIN");

        // Lock and validate the loan.
        const loanResult = await client.query(`
            SELECT
                id,
                school_id,
                library_member_id,
                status,
                returned_date
            FROM public.library_loans
            WHERE id = $1
              AND is_active = TRUE
            FOR UPDATE;
        `, [loan_id]);

        if (loanResult.rows.length === 0) {
            await client.query("ROLLBACK");

            return res.status(404).json({
                success: false,
                message: "Library loan not found.",
                errors: []
            });
        }

        const loan = loanResult.rows[0];

        // Verify the library member belongs to the loan.
        const memberResult = await client.query(`
            SELECT
                id,
                school_id,
                status,
                is_active
            FROM public.library_members
            WHERE id = $1
              AND is_active = TRUE
            FOR UPDATE;
        `, [loan.library_member_id]);

        if (memberResult.rows.length === 0) {
            await client.query("ROLLBACK");

            return res.status(404).json({
                success: false,
                message: "Library member associated with this loan was not found.",
                errors: []
            });
        }

        const member = memberResult.rows[0];

        if (member.school_id !== loan.school_id) {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Library loan and member belong to different schools.",
                errors: []
            });
        }

        if (member.status !== "ACTIVE") {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "Library member is not active.",
                errors: []
            });
        }

        // An overdue fine must be attached to an overdue loan.
        if (fine_type === "OVERDUE" && loan.status !== "OVERDUE") {
            await client.query("ROLLBACK");

            return res.status(400).json({
                success: false,
                message: "An overdue fine can only be created for an overdue loan.",
                errors: []
            });
        }

        // Prevent multiple active fines for the same loan.
        const existingFineResult = await client.query(`
            SELECT id
            FROM public.library_fines
            WHERE loan_id = $1
              AND is_active = TRUE
              AND status <> 'WAIVED'
            LIMIT 1;
        `, [loan_id]);

        if (existingFineResult.rows.length > 0) {
            await client.query("ROLLBACK");

            return res.status(409).json({
                success: false,
                message: "An active fine already exists for this library loan.",
                errors: []
            });
        }

        // Create the fine.
        const fineResult = await client.query(`
            INSERT INTO public.library_fines (
                school_id,
                loan_id,
                library_member_id,
                fine_type,
                amount,
                amount_paid,
                status,
                description,
                created_by
            )
            VALUES (
                $1,
                $2,
                $3,
                $4,
                $5,
                0,
                'OUTSTANDING',
                $6,
                $7
            )
            RETURNING
                id,
                public_id,
                school_id,
                loan_id,
                library_member_id,
                fine_type,
                amount,
                amount_paid,
                issued_date,
                paid_date,
                status,
                description,
                created_by;
        `, [
            loan.school_id,
            loan.id,
            loan.library_member_id,
            fine_type,
            numericAmount,
            description || null,
            created_by || null
        ]);

        await client.query("COMMIT");

        res.status(201).json({
            success: true,
            message: "Library fine created successfully.",
            data: fineResult.rows[0]
        });
    } catch (error) {
        try {
            await client.query("ROLLBACK");
        } catch (rollbackError) {
            console.error("Fine transaction rollback failed:", rollbackError);
        }

        console.error("Failed to create library fine:", error);

        res.status(500).json({
            success: false,
            message: "Failed to create library fine.",
            errors: []
        });
    } finally {
        client.release();
    }
};