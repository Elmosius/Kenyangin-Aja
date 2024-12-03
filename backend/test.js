// import bcrypt from "bcryptjs";

// const password = "password";

// // Hash password baru
// bcrypt.hash(password, 10, (err, hash) => {
//   if (err) throw err;
//   console.log("Generated hash:", hash);

//   // Bandingkan hash dengan input password
//   bcrypt.compare(password, hash, (err, isMatch) => {
//     if (err) throw err;
//     console.log("Password match:", isMatch); // Output: true
//   });
// });

import placekit from "@placekit/client-js";

const pk = placekit("pk_5X+m+lN1ojjZY56xPcQ9rM0wxAQA+Cip5LPL11dTn8U=");

pk.search("Big Papa Pasta & Steak").then((res) => {
  console.log(res.results);
});
