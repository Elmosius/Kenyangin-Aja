import mongoose from "mongoose";
import bcrypt from "bcryptjs";

// Buat schema user
const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "Name is required"],
  },
  email: {
    type: String,
    required: true,
    unique: [true, "Email is required"],
  },
  password: {
    type: String,
    required: [true, "Password is required"],
  },
  role: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Role",
    default: null,
  },
});

// Hash password sebelum menyimpan
userSchema.pre("save", async function (next) {
  console.info("masuk");
  if (!this.isModified("password")) return next();
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// Validasi password
userSchema.methods.matchPassword = async function (input) {
  return await bcrypt.compare(input, this.password);
  //   const isMatch = await bcrypt.compare(input, this.password);
  //   console.log("Input password:", input);
  //   console.log("Hashed password:", this.password);
  //   console.log("Password match:", isMatch);
  //   return isMatch;
};

const User = mongoose.model("User", userSchema);
export default User;
