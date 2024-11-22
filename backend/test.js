import bcrypt from "bcryptjs";

const password = "password";

// Hash password baru
bcrypt.hash(password, 10, (err, hash) => {
  if (err) throw err;
  console.log("Generated hash:", hash);

  // Bandingkan hash dengan input password
  bcrypt.compare(password, hash, (err, isMatch) => {
    if (err) throw err;
    console.log("Password match:", isMatch); // Output: true
  });
});
