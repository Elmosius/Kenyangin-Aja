import mongoose from "mongoose";
import bcrypt from "bcryptjs";

// buat schema user
const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
});

// hash paswword
userSchema.pre("save", async (next) => {
  if (!this.isModified("password")) return next();
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// validasi password
userSchema.methods.matchPassword = async (input) => {
  return await bcrypt.compare(input, this.password);
};

const User = mongoose.model("User", userSchema);
export default User;
