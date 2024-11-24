import express from "express";
import { addFood, deleteFood, getFoodDetail, getFoods, updateFood } from "../controllers/foodController.js";
import { validateFood } from "../validations/foodValidation.js";
import handleValidation from "../middlewares/vallidateMiddleware.js";

const router = express.Router();

router.get("/", getFoods);
router.get("/:id", getFoodDetail);
router.post("/", validateFood, handleValidation, addFood);
router.put("/:id", validateFood, handleValidation, updateFood);
router.delete("/:id", deleteFood);

export default router;
