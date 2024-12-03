import mongoose from "mongoose";

const foodSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Food name is required"],
    },
    description: {
      type: String,
      required: [true, "Description is required"],
    },
    locations: [
      {
        city: { type: String, required: true },
        address: { type: String, required: true },
        url: { type: String },
      },
    ],
    imageUrl: {
      type: String,
      default: "",
    },
    rating: {
      type: Number,
      default: 0,
      min: 0,
      max: 5,
    },
    tiktokRef: {
      type: String,
      ref: "TikTok",
      default: null,
    },
  },
  {
    timestamps: true,
  }
);

const Food = mongoose.model("Food", foodSchema);
export default Food;
