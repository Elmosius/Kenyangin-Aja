import 'package:flutter/material.dart';
import 'package:main/core/widgets/empty_status.dart';
import 'package:main/core/widgets/grid_card.dart';
import 'package:main/data/models/food.dart';
import 'package:go_router/go_router.dart';

class FoodGridWidget extends StatelessWidget {
  final List<Food> foods;
  final String emptyMessage;
  final Widget Function(Food)? trailingIconBuilder;

  const FoodGridWidget({
    required this.foods,
    required this.emptyMessage,
    this.trailingIconBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double childAspectRatio = screenWidth < 800 ? 3 / 3 : 8 / 5;

    if (foods.isEmpty) {
      return Center(
        child: EmptyStateWidget(
          message: emptyMessage,
          imagePath: 'images/status_empty.png',
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: foods.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth < 800 ? 2 : 5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 32,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final food = foods[index];
        return GridCardWidget(
          name: food.name,
          imageUrl: food.imageUrl,
          rating: food.rating,
          onTap: () {
            context.goNamed('food_detail', extra: food);
          },
          trailingIcon:
              trailingIconBuilder != null ? trailingIconBuilder!(food) : null,
        );
      },
    );
  }
}
