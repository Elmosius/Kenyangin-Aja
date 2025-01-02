import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:main/data/providers/tiktok_provider.dart';
import 'package:main/data/providers/favorite_provider.dart';
import 'package:main/data/providers/auth_state_notifier.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  // ignore: library_private_types_in_public_api
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  bool? _isFavorite;

  @override
  Widget build(BuildContext context) {
    final foodAsync = ref.watch(foodDetailProvider(widget.postId));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: foodAsync.when(
        data: (food) {
          if (_isFavorite == null) {
            final authState = ref.read(authStateNotifierProvider.notifier);
            final userId = authState.userProfile?['id'];
            _isFavorite =
                ref.read(favoriteProvider.notifier).isFavorite(userId, food.id);
          }

          return _buildContent(context, ref, food);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading post: $error'),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, Food food) {
    final tiktokAsync = ref.watch(tiktokDetailProvider(food.tiktokRef ?? ''));
    final authState = ref.watch(authStateNotifierProvider.notifier);
    final userId = authState.userProfile?['id'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar utama
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              food.imageUrl,
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
                food.name,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.circle,
                size: 5,
              ),
              const SizedBox(width: 8),
              Text(
                '${food.rating} ratings',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  _isFavorite == true ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.hijau,
                ),
                onPressed: () async {
                  if (userId != null) {
                    setState(() {
                      _isFavorite = !_isFavorite!;
                    });

                    if (_isFavorite == true) {
                      await ref
                          .read(favoriteProvider.notifier)
                          .addFavorite(userId, food.id);
                    } else {
                      await ref
                          .read(favoriteProvider.notifier)
                          .removeFavorite(userId, food.id);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please log in to like posts'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Deskripsi
          Text(
            food.description,
            textAlign: TextAlign.justify,
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
              const Icon(Icons.location_pin, color: Colors.red, size: 20),
              Text(
                food.locations.isNotEmpty
                    ? '${food.locations[0].city}, ${food.locations[0].address}'
                    : 'Lokasi tidak tersedia',
                style: GoogleFonts.inter(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Map placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(
                child: Text(
                  "Map Placeholder",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Lokasi lainnya
          if (food.locations.length > 1) ...[
            Text(
              "Lokasi lainnya",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...food.locations.skip(1).map((location) {
              return InkWell(
                onTap: () {
                  // Navigasi ke lokasi link
                },
                child: Text(
                  "> ${location.city}",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.hitam,
                    decoration: TextDecoration.underline,
                  ),
                ),
              );
            }),
          ],
          const SizedBox(height: 16),

          // Review dari kreator
          Text(
            "Review dari kreator",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          tiktokAsync.when(
            data: (tiktok) => Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text(
                        "Video Placeholder",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tiktok.creator.name,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }
}
