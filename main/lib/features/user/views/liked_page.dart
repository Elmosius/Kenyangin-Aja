import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:main/data/providers/favorite_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class LikedPage extends ConsumerWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider.notifier);
    final userId = authState.userProfile?['id'];

    final favoritesAsync = ref.watch(favoriteProvider);

    ref.read(favoriteProvider.notifier).fetchFavorites(userId);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
            favoritesAsync.when(
              data: (favorites) => favorites.isEmpty
                  ? const Center(
                      child: Text(
                        "Kamu belum menandai tempat!",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favorites.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 32 / 40,
                      ),
                      itemBuilder: (context, index) {
                        final food = favorites[index];
                        return GestureDetector(
                          onTap: () {
                            // context.push('/food_detail', extra: food);
                          },
                          child: Stack(
                            children: [
                              // Background image
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.45),
                                      BlendMode.darken,
                                    ),
                                    image: NetworkImage(food.imageUrl),
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
                                      food.name,
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
                                          "${food.rating.toStringAsFixed(1)} ratings",
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
                              // Favorite Icon
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(favoriteProvider.notifier)
                                        .removeFavorite(userId, food.id);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
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
  }
}
