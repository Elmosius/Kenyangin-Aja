import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import connectDB from "./config/db.js";
import authRoute from "./routes/authRoute.js";
import userRoute from "./routes/userRoute.js";
import roleRoute from "./routes/roleRoute.js";
import foodRoute from "./routes/foodRoute.js";
import favRoute from "./routes/favoriteRoute.js";
import xRoute from "./routes/twitterRoute.js";
import tiktokRoute from "./routes/tiktokRoute.js";
import initializeAdmin from "./start/initializeAdmin.js";
import initializeRoles from "./start/initializeRoles.js";

dotenv.config();
connectDB();

const app = express();

app.use(cors());
app.use(express.json());

// Routes
app.use("/auth", authRoute);
app.use("/users", userRoute);
app.use("/roles", roleRoute);
app.use("/foods", foodRoute);
app.use("/favorite", favRoute);
app.use("/api/twitter", xRoute);
app.use("/api/tiktok", tiktokRoute);

const PORT = process.env.PORT || 5000;

// buat admin dan role pertama kali
initializeAdmin();
initializeRoles();

app.listen(PORT, () => {
  console.log(`Server jalan di port ${PORT}`);
});
