import { body } from "express-validator";

const validateRole = [body("name").notEmpty().withMessage("Role name is required")];

export { validateRole };
