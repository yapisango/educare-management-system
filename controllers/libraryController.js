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
