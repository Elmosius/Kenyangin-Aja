import mongoose from "mongoose";
import bcrypt from "bcryptjs";

// Buat schema user
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
  role: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Role",
    default: null,
  },
});

// Hash password sebelum menyimpan
userSchema.pre("save", async function (next) {
  if (!this.isModified("password")) return next();
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// Validasi password
userSchema.methods.matchPassword = async function (input) {
  return await bcrypt.compare(input, this.password);
};

const User = mongoose.model("User", userSchema);
export default User;
