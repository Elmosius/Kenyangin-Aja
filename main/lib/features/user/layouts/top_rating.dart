import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/data/models/food.dart';
import 'package:go_router/go_router.dart';

class TopRatingWidget extends StatelessWidget {
  final List<Food> topRatingFoods;

  const TopRatingWidget({
    required this.topRatingFoods,
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
              "Top Rating",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed('top-rating');
              },
              child: const Text("See all"),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // List of Top Rating Foods
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topRatingFoods.length,
            itemBuilder: (context, index) {
              final food = topRatingFoods[index];
              return GestureDetector(
                onTap: () {
                  context.pushNamed('post-detail',
                      pathParameters: {'id': food.id});
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
                      SizedBox(
                        width: 80,
                        child: Text(
                          food.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
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
