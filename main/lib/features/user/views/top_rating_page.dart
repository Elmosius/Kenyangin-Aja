import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/empty_status.dart';
import 'package:main/core/widgets/grid_card.dart';
import 'package:main/core/widgets/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:main/data/providers/food_provider.dart';

class TopRatingPage extends StatefulWidget {
  const TopRatingPage({super.key});

  @override
  State<TopRatingPage> createState() => _TopRatingPageState();
}

class _TopRatingPageState extends State<TopRatingPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double childAspectRatio = screenWidth < 800 ? 3 / 4 : 8 / 5;

    return Consumer(
      builder: (context, ref, child) {
        final foodsAsync = ref.watch(foodProvider);

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: foodsAsync.when(
            data: (foods) {
              final topRatingFoods = foods
                  .where((food) =>
                      food.rating >= 4.5 &&
                      food.name
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                  .toList()
                ..sort((a, b) => b.rating.compareTo(a.rating));

              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Text(
                      "Top Rating",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Search Bar
                    SearchBarWidget(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Konten Grid atau Pesan Kosong
                    topRatingFoods.isEmpty
                        ? const Center(
                            child: EmptyStateWidget(
                              message:
                                  "Maaf, saat ini belum ada tempat yang cocok dengan pencarian Anda.",
                              imagePath: 'images/status_empty.png',
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: topRatingFoods.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: screenWidth < 600 ? 2 : 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 32,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemBuilder: (context, index) {
                              final food = topRatingFoods[index];
                              return GridCardWidget(
                                name: food.name,
                                imageUrl: food.imageUrl,
                                rating: food.rating,
                                onTap: () {
                                  context.goNamed('food_detail', extra: food);
                                },
                              );
                            },
                          ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }
}
