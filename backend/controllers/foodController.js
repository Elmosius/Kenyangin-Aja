import Food from "../models/foodModel.js";
import TikTok from "../models/tiktokModel.js";

const getFoods = async (req, res) => {
  try {
    const foods = await Food.find();
    res.status(200).json(foods);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

const getFoodDetail = async (req, res) => {
  const { id } = req.params;

  try {
    const food = await Food.findById(id);
    if (!food) {
      return res.status(404).json({ message: "Food not found" });
    }

    res.status(200).json(food);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const addFood = async (req, res) => {
  const { name, description, locations, imageUrl, tiktokRef } = req.body;

  try {
    let newFood;

    if (tiktokRef) {
      const tiktokData = await TikTok.findOne({ id: tiktokRef });
      if (!tiktokData) {
        return res.status(404).json({ message: "TikTok video not found" });
      }

      const existingFood = await Food.findOne({ tiktokRef: tiktokRef });
      if (existingFood) {
        return res.status(400).json({ message: "This TikTok video is already linked to a food item" });
      }

      const { like_count, share_count, play_count } = tiktokData;
      let calculatedRating = ((like_count * 0.5 + share_count * 0.3 + play_count * 0.2) / 100000).toFixed(1);

      if (calculatedRating > 5) {
        calculatedRating = 5;
      }
      newFood = await Food.create({
        name: name,
        description: description,
        imageUrl: imageUrl,
        rating: calculatedRating,
        locations: locations || [],
        tiktokRef: tiktokRef,
      });
    }

    res.status(201).json({
      message: "Food added successfully",
      food: newFood,
    });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

const updateFood = async (req, res) => {
  const { id } = req.params;
  const { name, description, locations, imageUrl, rating, tiktokId } = req.body;

  try {
    let updatedFood;

    if (tiktokId) {
      const tiktokData = await TikTok.findById(tiktokId);
      if (!tiktokData) {
        return res.status(404).json({ message: "TikTok video not found" });
      }

      const { like_count, share_count, play_count } = tiktokData;
      const calculatedRating = Math.min(5, (like_count * 0.5 + share_count * 0.3 + play_count * 0.2) / 100000);

      updatedFood = await Food.findByIdAndUpdate(
        id,
        {
          name: name,
          description: description,
          imageUrl: imageUrl,
          rating: calculatedRating,
          locations: locations || [],
          tiktokRef: tiktokId,
        },
        { new: true, runValidators: true }
      );
    } else {
      updatedFood = await Food.findByIdAndUpdate(id, { name, description, locations, imageUrl, rating }, { new: true, runValidators: true });
    }

    if (!updatedFood) {
      return res.status(404).json({ message: "Food not found" });
    }

    res.status(200).json({
      message: "Food updated successfully",
      food: updatedFood,
    });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

const deleteFood = async (req, res) => {
  const { id } = req.params;

  try {
    const deletedFood = await Food.findByIdAndDelete(id);

    if (!deletedFood) {
      return res.status(404).json({ message: "Food not found" });
    }

    res.status(200).json({
      message: "Food deleted successfully",
    });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

export { addFood, getFoods, getFoodDetail, updateFood, deleteFood };
