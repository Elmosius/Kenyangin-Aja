import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/providers/food_provider.dart';

class FoodListPage extends ConsumerWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsAsync = ref.watch(foodProvider);
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: const Text('Food List')),
      body: foodsAsync.when(
        data: (foods) => _buildTable(foods, context, ref, isLandscape),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildTable(
      List<Food> foods, BuildContext context, WidgetRef ref, bool isLandscape) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('City')),
            DataColumn(label: Text('Address')),
            DataColumn(label: Text('Rating')),
            DataColumn(label: Text('Image')),
            DataColumn(label: Text('TikTok Ref')),
            DataColumn(label: Text('Actions')),
          ],
          rows: foods.map((food) {
            final location =
                food.locations.isNotEmpty ? food.locations.first : null;
            return DataRow(
              cells: [
                DataCell(Text(food.name)),
                DataCell(Text(food.description)),
                DataCell(Text(location?.city ?? 'N/A')),
                DataCell(Text(location?.address ?? 'N/A')),
                DataCell(Text(food.rating.toStringAsFixed(1))),
                DataCell(
                  SizedBox(
                    width: isLandscape
                        ? 100
                        : 50, // Adjust width based on orientation
                    height: isLandscape
                        ? 100
                        : 50, // Adjust height based on orientation
                    child: Image.network(food.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                DataCell(Text(food.tiktokRef ?? 'N/A')),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/add_food',
                          arguments: food,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Food'),
                            content: const Text(
                                'Are you sure you want to delete this food?'),
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
                        if (confirmed ?? false) {
                          ref.read(foodProvider.notifier).deleteFood(food.id);
                        }
                      },
                    ),
                  ],
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
