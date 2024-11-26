import express from "express";
import { getTrendingTweets } from "../controllers/twitterController.js";

const router = express.Router();
router.get("/", getTrendingTweets);

export default router;
