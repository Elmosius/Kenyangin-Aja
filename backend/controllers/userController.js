import User from "../models/userModel.js";
import Role from "../models/roleModel.js";

const createUser = async (req, res) => {
  const { name, email, password, role } = req.body;

  try {
    const roleExists = await Role.findById(role);
    if (!roleExists) {
      return res.status(400).json({ message: "Invalid role" });
    }

    const user = await User.create({ name, email, password, role });

    const populatedUser = await User.findById(user._id).populate("role", "name");

    res.status(201).json({ message: "User created successfully", user: populatedUser });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const getUsers = async (req, res) => {
  try {
    const users = await User.find().populate("role", "name");
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id).populate("role", "name");
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const updateUser = async (req, res) => {
  const { role } = req.body;

  try {
    if (role) {
      const roleExists = await Role.findById(role);
      if (!roleExists) {
        return res.status(400).json({ message: "Invalid role" });
      }
    }

    const user = await User.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    }).populate("role", "name");

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({ message: "User updated successfully", user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const deleteUser = async (req, res) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({ message: "User deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export { createUser, getUsers, getUserById, updateUser, deleteUser };
