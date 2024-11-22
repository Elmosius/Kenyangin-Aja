import bcrypt from "bcryptjs";
import Role from "../models/roleModel.js";
import User from "../models/userModel.js";

const initializeAdmin = async () => {
  try {
    const adminRole = await Role.findOne({ name: "admin" });
    if (!adminRole) {
      throw new Error("Admin role not found. Please initialize roles first.");
    }

    const existingAdmin = await User.findOne({ email: "admin@gmail.com" });
    if (!existingAdmin) {
      const hashedPassword = await bcrypt.hash("password", 10);
      await User.create({
        name: "Admin",
        email: "admin@gmail.com",
        password: hashedPassword,
        role: adminRole._id,
      });
      console.log("Admin account created with email: admin@gmail.com");
    }
  } catch (error) {
    console.error("Error initializing admin:", error.message);
  }
};

export default initializeAdmin;
