import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/food_grid.dart';
import 'package:main/core/widgets/search_bar.dart';
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
                    Text(
                      "Top Rating",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SearchBarWidget(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    FoodGridWidget(
                      foods: topRatingFoods,
                      emptyMessage:
                          "Maaf, saat ini belum ada tempat dengan rating tinggi yang cocok.",
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
