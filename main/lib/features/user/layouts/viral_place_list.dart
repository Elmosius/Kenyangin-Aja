import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/food_grid.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
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
                context.pushNamed('viral');
              },
              child: const Text("See all"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Grid Konten
        FoodGridWidget(
          foods: viralPlacesFoods,
          emptyMessage: "Tidak ada tempat viral untuk saat ini.",
          aspectRatio: 5 / 3,
        ),
      ],
    );
  }
}
