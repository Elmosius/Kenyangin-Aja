import express from "express";
import handleValidation from "../middlewares/validateMiddleware.js";
import { validateFavorite } from "../validations/foodValidation.js";
import { addFavorite, removeFavorite } from "../controllers/favoriteController.js";

const router = express.Router();

router.post("/add", validateFavorite, handleValidation, addFavorite);
router.post("/remove", validateFavorite, handleValidation, removeFavorite);

export default router;
