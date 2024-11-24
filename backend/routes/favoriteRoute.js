import express from "express";
import { validateFavorite } from "../validations/foodValidation.js";
import { addFavorite, removeFavorite } from "../controllers/favoriteController.js";
import handleValidation from "../middlewares/vallidateMiddleware.js";

const router = express.Router();

router.post("/", validateFavorite, handleValidation, addFavorite);
router.delete("/", validateFavorite, handleValidation, removeFavorite);

export default router;
