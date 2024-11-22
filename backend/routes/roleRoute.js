import express from "express";
import { getRoles } from "../controllers/roleController.js";

const router = express.Router();

// Endpoint untuk mendapatkan semua role
router.get("/", getRoles);

export default router;
