import express from "express";
import { createUser, deleteUser, getUserById, getUsers, updateUser } from "../controllers/userController.js";
import { validateUser } from "../validations/userValidation.js";
import handleValidation from "../middlewares/vallidateMiddleware.js";

const router = express.Router();

router.get("/", getUsers);
router.get("/:id", getUserById);
router.post("/", validateUser, handleValidation, createUser);
router.put("/:id", updateUser);
router.delete("/:id", deleteUser);

export default router;
