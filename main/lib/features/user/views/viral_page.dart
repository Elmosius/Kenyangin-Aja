import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViralPage extends StatelessWidget {
  const ViralPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk Top Rating
    final topRatingData = List.generate(
      10,
      (index) => {
        "name": "Starbuck Borobudur",
        "imageUrl":
            "https://images.unsplash.com/photo-1680220700404-a165278e95e7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdG9yYW58ZW58MHx8MHx8fDA%3D",
        "rating": 4.8,
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            Text(
              "Tempat Makanan lagi viral nich... ",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
                hintText: "Search menu, restaurant or etc",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Konten Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topRatingData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 32 / 40,
              ),
              itemBuilder: (context, index) {
                final food = topRatingData[index];
                return GestureDetector(
                  onTap: () {
                    // Tambahkan navigasi ke detail halaman jika diperlukan
                  },
                  child: Stack(
                    children: [
                      // Background image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(food["imageUrl"] as String),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Text & Rating
                      Positioned(
                        bottom: 16,
                        left: 8,
                        right: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food["name"] as String,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.orange, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "${(food["rating"] as double).toStringAsFixed(1)} ratings",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
