import User from "../models/userModel.js";

const getUsers = async (req, res) => {
  try {
    const users = await User.find().populate("role", "name");
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export { getUsers };
