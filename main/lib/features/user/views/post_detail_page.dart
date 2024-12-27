import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk halaman detail
    final postDetail = {
      "name": "Big Papa & Steak",
      "imageUrl":
          "https://images.unsplash.com/photo-1680220700404-a165278e95e7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdG9yYW58ZW58MHx8MHx8fDA%3D",
      "rating": 4.8,
      "liked": true,
      "description":
          "Lorem ipsum dolor sit amet consectetur adipiscing elit. Accusamus a nihil recusandae neque. Nulla architecto veritatis fugiat, voluptas eaque ex! Provident deserunt maiores fuga pariatur repellendus.",
      "location": "Bandung, Jl. Naripan No. 38",
      "mapUrl": "https://www.google.com/maps", // Ganti dengan URL peta
      "otherLocations": [
        {"city": "Cimahi", "link": "https://waze.com"},
        {"city": "Surabaya", "link": "https://google.com/maps"}
      ],
      "creatorReview": {
        "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
        "creatorName": "Melki Balipa Emil",
        "avatarColor": Colors.orange
      }
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                postDetail["imageUrl"]! as String,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Nama tempat dan rating
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  postDetail["name"]! as String,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    const Icon(Icons.circle, size: 8),
                    const SizedBox(width: 4),
                    Text(
                      "${postDetail["rating"]} Ratings",
                      style: GoogleFonts.inter(fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    postDetail["liked"] as bool
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColors.hijau,
                  ),
                  onPressed: () {
                    // Tambahkan logika like/unlike
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Deskripsi
            Text(
              textAlign: TextAlign.justify,
              postDetail["description"]! as String,
              style: GoogleFonts.inter(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            // Lokasi
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 20,
                ),
                Text(
                  postDetail["location"]! as String,
                  style: GoogleFonts.inter(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Map iframe (dummy)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    "Map Iframe Placeholder",
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Lokasi lainnya
            Text(
              "Lokasi lainnya",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...(postDetail["otherLocations"]! as List).map<Widget>((location) {
              return InkWell(
                onTap: () {
                  // Navigasi ke lokasi link
                },
                child: Text(
                  "> ${location["city"]}",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.hitam,
                    decoration: TextDecoration.underline,
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            // Review dari kreator
            Text(
              "Review dari kreators",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    "Video Iframe Placeholder",
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: (postDetail["creatorReview"]!
                      as Map)["avatarColor"] as Color,
                ),
                const SizedBox(width: 8),
                Text(
                  (postDetail["creatorReview"]! as Map)["creatorName"]!
                      as String,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
