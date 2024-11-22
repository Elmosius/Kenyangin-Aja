import { body } from "express-validator";

// prettier-ignore
const validateRegister = [
    body('name').notEmpty().withMessage('Name is required'),
    body('email').isEmail().withMessage('Valid email is required'),
    body('password')
    .isLength({ min: 6 })
    .withMessage('Password must be at least 6 characters'),
];

// prettier-ignore
const validateLogin = [
  body('email').isEmail().withMessage('Valid email is required'),
  body('password').notEmpty().withMessage('Password is required'),
];

export { validateRegister, validateLogin };
