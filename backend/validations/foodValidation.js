import { body } from "express-validator";

const validateFood = [
  body("name").notEmpty().withMessage("Name is required"),
  body("description").notEmpty().withMessage("Description is required "),
  body("locations")
    .optional()
    .isArray()
    .withMessage("Locations must be an array")
    .custom((locations) => {
      if (!Array.isArray(locations)) {
        throw new Error("Locations must be an array");
      }
      locations.forEach((location) => {
        if (!location.city || !location.address) {
          throw new Error("Each location must have 'city' and 'address'");
        }
      });
      return true;
    }),

  body("imageUrl").optional().isString().withMessage("Image URL must be a string"),
  body("tiktokRef").optional().isString().withMessage("TikTok ID must be a string"),
  body("rating").not().exists().withMessage("Rating cannot be set manually"),
];

const validateFavorite = [body("userId").notEmpty().withMessage("User ID is required"), body("foodId").notEmpty().withMessage("Food ID is required")];

export { validateFood, validateFavorite };
