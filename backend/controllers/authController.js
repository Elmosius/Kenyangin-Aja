import Role from "../models/roleModel.js";
import User from "../models/userModel.js";
import jwt from "jsonwebtoken";

const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({ message: "Email atau password salah" });
    }

    const isMatch = await user.matchPassword(password);
    if (!isMatch) {
      return res.status(401).json({ message: "Email atau password salah" });
    }

    const role = await Role.findById(user.role);

    const token = jwt.sign(
      {
        id: user._id,
      },
      process.env.JWT_SECRET,
      { expiresIn: "1d" }
    );

    res.status(200).json({
      message: "Berhasil login",
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        role: role.name,
        createdAt: user.createdAt,
      },
    });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

const registerUser = async (req, res) => {
  const role = await Role.findOne({ name: "user" });
  if (!role) {
    throw new Error("User role not found. Please initialize roles first.");
  }

  const { name, email, password } = req.body;

  try {
    // cek email udah ada atau belum
    const exist = await User.findOne({ email });
    if (exist) {
      return res.status(400).json({ message: "Email sudah terdaftar" });
    }

    // buat user baru
    const newUser = await User.create({
      name,
      email,
      password,
      role: role._id,
    });

    // jwt token
    const token = jwt.sign(
      {
        id: newUser._id,
      },
      process.env.JWT_SECRET,
      { expiresIn: "1d" }
    );

    res.status(201).json({
      message: "Berhasil register",
      user: {
        id: newUser._id,
        name: newUser.name,
        email: newUser.email,
        role: role.name,
        createdAt: user.createdAt,
      },
      token,
    });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

const verifyToken = async (req, res) => {
  const { token } = req.body;

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const user = await User.findById(decoded.id);

    if (!user) {
      return res.status(401).json({ message: "User not found" });
    }

    const role = await Role.findById(user.role);

    res.status(200).json({
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        role: role.name,
        createdAt: user.createdAt,
      },
    });
  } catch (error) {
    res.status(401).json({ message: "Invalid or expired token" });
  }
};

export { loginUser, registerUser, verifyToken };
