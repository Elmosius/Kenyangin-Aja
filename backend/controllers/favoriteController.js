import User from "../models/userModel.js";
import Food from "../models/foodModel.js";

const addFavorite = async (req, res) => {
  const { userId, foodId } = req.body;
  try {
    const user = await User.findById(userId);
    const food = await Food.findById(foodId);
    if (!user || !food) {
      return res.status(404).json({ message: "User or food not found" });
    }

    if (!user.favorites.includes(foodId)) {
      user.favorites.push(foodId);
      await user.save();
    }

    res.status(200).json({ message: "Food added to favorites", favorites: user.favorites });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const removeFavorite = async (req, res) => {
  const { userId, foodId } = req.body;
  try {
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    user.favorites = user.favorites.filter((fav) => fav.toString() !== foodId);
    await user.save();

    res.status(200).json({ message: "Food removed from favorites", favorites: user.favorites });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export { addFavorite, removeFavorite };
