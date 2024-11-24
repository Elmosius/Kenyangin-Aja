import { body } from "express-validator";

const validateFood = [
  body("name").notEmpty().withMessage("Name is required"),
  body("description").notEmpty().withMessage("Description is required"),
  body("locations").notEmpty().withMessage("Location is required"),
  body("rating").optional().isFloat({ min: 0, max: 5 }).withMessage("Rating must be between 0 and 5"),
];

export { validateFood };
