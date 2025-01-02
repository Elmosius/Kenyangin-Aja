import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodActionButtons extends ConsumerWidget {
  final String foodId;

  const FoodActionButtons({super.key, required this.foodId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          icon: Icon(MdiIcons.eye, color: Colors.black, size: 20),
          onPressed: () {
            context.goNamed(
              'food-detail',
              pathParameters: {'id': foodId},
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blueGrey, size: 20),
          onPressed: () {
            context.goNamed(
              'edit-food',
              pathParameters: {'id': foodId},
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
          onPressed: () async {
            final confirmed = await _showDeleteConfirmation(context);
            if (confirmed ?? false) {
              try {
                await ref.read(foodProvider.notifier).deleteFood(foodId);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Food deleted successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error deleting food: $e'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Food'),
        content: const Text(
          'Are you sure you want to delete this food?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
