import Food from "../models/foodModel.js";

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

export { getFoodDetail };

const addFood = async (req, res) => {
  const { name, description, locations, imageUrl, rating } = req.body;

  try {
    const newFood = await Food.create({
      name,
      description,
      locations,
      imageUrl,
      rating,
    });

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
  const { locations } = req.body;

  try {
    const updatedFood = await Food.findByIdAndUpdate(
      id,
      { locations },
      {
        new: true,
        runValidators: true,
      }
    );

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

export { addFood, getFoods, updateFood, deleteFood };
