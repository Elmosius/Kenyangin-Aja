const protect = async (req, res, next) => {
  let token = req.headers.authorization?.split(" ")[1];
  if (!token) {
    return res.status(401).json({ message: "Not authorized" });
  }
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = await User.findById(decoded.id).populate("role");
    next();
  } catch (e) {
    return res.status(401).json({ message: "Not authorized" });
  }
};

const admin = (req, res, next) => {
  if (req.user && req.user.role.name === "admin") {
    return next();
  } else {
    return res.status(403).json({ message: "Access denied" });
  }
};
