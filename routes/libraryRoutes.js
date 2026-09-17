import express from "express";
import { getBooks, getBookById, getMembers, getLoans, getFines, createLoan, returnLoan, createFine, payFine, renewLoan } from "../controllers/libraryController.js";

const router = express.Router();

router.get("/books", getBooks);
router.get("/books/:id", getBookById);
router.get("/members", getMembers);
router.get("/loans", getLoans);
router.post("/loans", createLoan);
router.post("/loans/:id/return", returnLoan);
router.post("/loans/:id/renew", renewLoan);
router.get("/fines", getFines);
router.post("/fines", createFine);
router.post("/fines/:id/pay", payFine);

export default router;
