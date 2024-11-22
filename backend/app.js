import express from "express";
import dotenv from "dotenv";
import connectDB from "./config/db.js";
import authRoutes from "./routes/authRoutes.js";
import initializeAdmin from "./start/initializeRoles.js";
import initializeRoles from "./start/initializeAdmin.js";

dotenv.config();
connectDB();

const app = express();
app.use(express.json());

// Routes
app.use("/auth", authRoutes);

const PORT = process.env.PORT || 5000;

// buat admin dan role pertama kali
initializeAdmin();
initializeRoles();

app.listen(PORT, () => {
  console.log(`Server jalan di port ${PORT}`);
});
