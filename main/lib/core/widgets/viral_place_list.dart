import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/grid_card.dart';
import 'package:main/data/models/food.dart';
import 'package:go_router/go_router.dart';

class ViralPlacesWidget extends StatelessWidget {
  final List<Food> viralPlacesFoods;

  const ViralPlacesWidget({
    required this.viralPlacesFoods,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double childAspectRatio = screenWidth < 800 ? 5 / 4 : 8 / 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul dan Tombol Lihat Semua
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
              onPressed: () {
                context.goNamed('viral');
              },
              child: const Text("See all"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Grid Konten
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viralPlacesFoods.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth < 600 ? 2 : 5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final food = viralPlacesFoods[index];
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
    );
  }
}
