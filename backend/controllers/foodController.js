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
  const { name, description, locations, imageUrl, tiktokRef } = req.body;

  try {
    // Ambil data food lama
    const existingFood = await Food.findById(id);
    if (!existingFood) {
      return res.status(404).json({ message: "Food not found" });
    }

    // Jika TikTok Ref tidak diubah, gunakan nilai lama
    const finalTikTokRef = tiktokRef || existingFood.tiktokRef;

    // Jika TikTok Ref diubah, validasi
    if (tiktokRef && tiktokRef !== existingFood.tiktokRef) {
      const tiktokData = await TikTok.findOne({ id: tiktokRef });
      if (!tiktokData) {
        return res.status(404).json({ message: "TikTok video not found" });
      }

      const existingFoodWithSameRef = await Food.findOne({ tiktokRef });
      if (existingFoodWithSameRef) {
        return res.status(400).json({ message: "This TikTok video is already linked to another food item" });
      }
    }

    // Hitung ulang rating jika TikTok Ref berubah
    let calculatedRating = existingFood.rating;
    if (tiktokRef && tiktokRef !== existingFood.tiktokRef) {
      const tiktokData = await TikTok.findOne({ id: tiktokRef });
      const { like_count, share_count, play_count } = tiktokData;
      calculatedRating = ((like_count * 0.5 + share_count * 0.3 + play_count * 0.2) / 100000).toFixed(1);
      if (calculatedRating > 5) calculatedRating = 5;
    }

    // Update food
    const updatedFood = await Food.findByIdAndUpdate(
      id,
      {
        name,
        description,
        locations: locations || existingFood.locations,
        imageUrl,
        rating: calculatedRating,
        tiktokRef: finalTikTokRef,
      },
      { new: true, runValidators: true }
    );

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
