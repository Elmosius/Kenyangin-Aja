import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: [
            // Header
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(
                      Icons.location_pin,
                      color: AppColors.hitam,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DropdownButton<String>(
                      value: "Bandung",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Bandung",
                          child: Text("Bandung"),
                        ),
                        DropdownMenuItem(
                          value: "Jakarta",
                          child: Text("Jakarta"),
                        ),
                        DropdownMenuItem(
                          value: "Surabaya",
                          child: Text("Surabaya"),
                        ),
                      ],
                      onChanged: (value) {},
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_outlined,
                            color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.filter_alt_outlined),
                hintText: "Search menu, restaurant or etc",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Top Rating Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Rating",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See all"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4, // Jumlah item top rating
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                              "https://via.placeholder.com/150"), // Gambar contoh
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ["Bigpapa", "Apa gtu", "Misalnya", "Apalagi"][index],
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Viral Places Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tempat yang lagi viral",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See all"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: 4, // Jumlah tempat viral
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://via.placeholder.com/150"), // Gambar contoh
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 16,
                        left: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              [
                                "Starbuck Borobudur",
                                "Baegopa Suhat"
                              ][index % 2],
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "4.8 ratings",
                                  style: GoogleFonts.montserrat(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
