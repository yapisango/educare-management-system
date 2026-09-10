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
