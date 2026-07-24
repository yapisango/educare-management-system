import express from "express";

const app = express();

const PORT = process.env.PORT || 8000;

app.use(express.static("public"));

app.get("/", (req, res) => {
    res.sendFile(new URL("./public/index.html", import.meta.url).pathname);
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});