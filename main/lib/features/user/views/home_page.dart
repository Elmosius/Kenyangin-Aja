import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:main/routes/app_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsAsync = ref.watch(foodProvider);

    const int maxTopRating = 5;
    const int maxViralPlaces = 4;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: foodsAsync.when(
        data: (foods) {
          final topRatingFoods = List<Food>.from(foods)
            ..sort((a, b) => b.rating.compareTo(a.rating))
            ..take(maxTopRating);

          final viralPlacesFoods = List<Food>.from(foods)
            ..sort((a, b) => (b.createdAt!).compareTo(a.createdAt!))
            ..take(maxViralPlaces);

          return SingleChildScrollView(
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
                    hoverColor: Colors.white,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                      ),
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
                    itemCount: topRatingFoods.length,
                    itemBuilder: (context, index) {
                      final food = topRatingFoods[index];
                      return GestureDetector(
                        onTap: () {
                          // context.goNamed('food_detail/${food.id}');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(food.imageUrl),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                food.name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
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
                    childAspectRatio: 32 / 20,
                  ),
                  itemCount: viralPlacesFoods.length,
                  itemBuilder: (context, index) {
                    final food = viralPlacesFoods.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        // context.goNamed('food_detail/${food.id}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(food.imageUrl),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.45),
                                BlendMode.darken),
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
                                    food.name,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: AppColors.orange, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${food.rating.toStringAsFixed(1)} ratings",
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
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text("Error: $error"),
        ),
      ),
    );
  }
}
