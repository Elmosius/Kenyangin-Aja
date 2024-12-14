import express from "express";
import { deleteTikTokVideo, getAllTikTokVideos, getSearchVideos, getTikTokVideoById } from "../controllers/tiktokController.js";

const router = express.Router();
router.get("/search", getSearchVideos);
router.get("/", getAllTikTokVideos);
router.get("/:id", getTikTokVideoById);
router.delete("/:id", deleteTikTokVideo);

export default router;
