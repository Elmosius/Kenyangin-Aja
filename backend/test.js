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

// import placekit from "@placekit/client-js";

// const pk = placekit("pk_5X+m+lN1ojjZY56xPcQ9rM0wxAQA+Cip5LPL11dTn8U=");

// pk.search("Big Papa Pasta & Steak").then((res) => {
//   console.log(res.results);
// });

// import axios from "axios";

// // Ganti dengan Mapbox Access Token Anda
// const MAPBOX_ACCESS_TOKEN = "pk.eyJ1IjoiZWxtb3NpdXNzdWxpIiwiYSI6ImNtNDc1aXMxNTAxam8yanNjbDEyZngyYjEifQ.X1wVo5i-IVHmGtLrjEGRcQ";

// // Fungsi untuk melakukan forward geocoding
// async function forwardGeocode(placeName) {
//   try {
//     // Bounding box untuk Bandung
//     const BBOX_BANDUNG = "107.5,-7.0,107.75,-6.75";

//     // Parameter types untuk bisnis/POI
//     const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(placeName)}.json?access_token=${MAPBOX_ACCESS_TOKEN}&bbox=${BBOX_BANDUNG}&country=id&types=poi`;

//     const response = await axios.get(url);

//     if (response.data.features.length > 0) {
//       const result = response.data.features[0];
//       console.log("Hasil Pencarian:");
//       console.log(`Nama Tempat: ${result.text}`);
//       console.log(`Alamat Lengkap: ${result.place_name}`);
//       console.log(`Koordinat: Latitude ${result.center[1]}, Longitude ${result.center[0]}`);
//     } else {
//       console.log("Lokasi tidak ditemukan di Bandung.");
//     }
//   } catch (error) {
//     console.error("Error saat mengambil data dari Mapbox:", error.message);
//   }
// }

// // Contoh penggunaan
// forwardGeocode("Big Papa & Steak");


  
