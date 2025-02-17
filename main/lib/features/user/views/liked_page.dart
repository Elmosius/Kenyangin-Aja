import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/core/widgets/food_grid.dart';
import 'package:main/core/widgets/search_bar.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:main/data/providers/favorite_provider.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authStateNotifierProvider.notifier);
        final userId = authState.userProfile?['id'];
        final favoritesAsync = ref.watch(favoriteProvider);

        // Fetch Favorites
        if (userId != null) {
          ref.read(favoriteProvider.notifier).fetchFavorites(userId);
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul
                Center(
                  child: Text(
                    "Tempat yang kamu tandai!",
                    style: GoogleFonts.inter(
                      color: AppColors.hitam,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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

                // Konten Utama
                favoritesAsync.when(
                  data: (favorites) {
                    // Filter berdasarkan pencarian
                    final filteredFavorites = favorites
                        .where((food) => food.name
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                        .toList();

                    return FoodGridWidget(
                      foods: filteredFavorites,
                      emptyMessage:
                          "Kamu belum menandai tempat yang cocok dengan pencarian Anda.",
                      trailingIconBuilder: (food) => IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          ref
                              .read(favoriteProvider.notifier)
                              .removeFavorite(userId!, food.id);
                        },
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Text(
                      'Error: $error',
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
