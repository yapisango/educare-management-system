import pool from "./database.js";

try {
    const result = await pool.query("SELECT NOW() AS current_time");

    console.log("=================================");
    console.log("PostgreSQL connection successful");
    console.log("Database time:", result.rows[0].current_time);
    console.log("=================================");
} catch (error) {
    console.error("PostgreSQL connection failed:");
    console.error(error.message);
} finally {
    await pool.end();
}
