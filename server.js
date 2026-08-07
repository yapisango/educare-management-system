import express from "express";
import pool from "./config/database.js";

const app = express();

const PORT = process.env.PORT || 8000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));

app.get("/api/health", async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                current_database() AS database_name,
                NOW() AS database_time
        `);

        res.status(200).json({
            status: "ok",
            service: "EduCare API",
            database: {
                status: "connected",
                name: result.rows[0].database_name,
                time: result.rows[0].database_time
            }
        });
    } catch (error) {
        console.error("Database health check failed:", error);

        res.status(503).json({
            status: "error",
            service: "EduCare API",
            database: {
                status: "disconnected"
            }
        });
    }
});

app.get("/", (req, res) => {
    res.sendFile(new URL("./public/index.html", import.meta.url).pathname);
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
