import express from "express";
import { getBooks, getBookById, getMembers, getLoans, getFines, createLoan, returnLoan } from "../controllers/libraryController.js";

const router = express.Router();

router.get("/books", getBooks);
router.get("/books/:id", getBookById);
router.get("/members", getMembers);
router.get("/loans", getLoans);
router.post("/loans", createLoan);
router.post("/loans/:id/return", returnLoan);
router.get("/fines", getFines);

export default router;
