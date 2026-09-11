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