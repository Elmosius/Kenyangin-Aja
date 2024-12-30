import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/data/models/food.dart';
import 'package:go_router/go_router.dart';

class TopRatingWidget extends StatelessWidget {
  final List<Food> topRatingFoods;
  const TopRatingWidget({required this.topRatingFoods, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              onPressed: () {
                context.goNamed('top-rating');
              },
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
                  // Navigate to Food Detail
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
      ],
    );
  }
}
