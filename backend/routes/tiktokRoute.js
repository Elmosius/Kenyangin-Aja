import express from "express";
import { getSearchVideos } from "../controllers/tiktokController.js";

const router = express.Router();
router.get("/", getSearchVideos);

export default router;
