import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/tiktok_preview.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:main/features/admin/layouts/location_list.dart';
import 'package:main/features/admin/layouts/food_image.dart';
import 'package:main/features/admin/layouts/food_info_card.dart';

class FoodDetailPage extends ConsumerWidget {
  final String foodId;
  const FoodDetailPage({super.key, required this.foodId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodAsync = ref.watch(foodDetailProvider(foodId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Detail',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: foodAsync.when(
        data: (food) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodImage(imageUrl: food.imageUrl),
                const SizedBox(height: 16),
                FoodInfoCard(food: food),
                const SizedBox(height: 16),
                LocationList(locations: food.locations),
                const SizedBox(height: 16),
                if (food.tiktokRef != null)
                  TikTokPreview(tiktokRef: food.tiktokRef!),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading food: $error'),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}
