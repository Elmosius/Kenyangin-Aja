import express from "express";
import { createRole, deleteRole, getRoleById, getRoles, updateRole } from "../controllers/roleController.js";
import { validateRole } from "../validations/roleValidation.js";
import handleValidation from "../middlewares/vallidateMiddleware.js";

const router = express.Router();

router.get("/", getRoles);
router.get("/:id", getRoleById);
router.post("/", validateRole, handleValidation, createRole);
router.put("/:id", validateRole, handleValidation, updateRole);
router.delete("/:id", deleteRole);
export default router;
