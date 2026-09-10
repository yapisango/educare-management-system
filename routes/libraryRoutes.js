import express from "express";
import { getBooks, getBookById, getMembers } from "../controllers/libraryController.js";

const router = express.Router();

router.get("/books", getBooks);
router.get("/books/:id", getBookById);
router.get("/members", getMembers);

export default router;
