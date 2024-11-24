import express from "express";
import { loginUser, registerUser } from "../controllers/authController.js";
import { validateLogin, validateRegister } from "../validations/authValidation.js";
import handleValidation from "../middlewares/vallidateMiddleware.js";

const router = express.Router();
router.post("/login", validateLogin, handleValidation, loginUser);
router.post("/register", validateRegister, handleValidation, registerUser);

export default router;
