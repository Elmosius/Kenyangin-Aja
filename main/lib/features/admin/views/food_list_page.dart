import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodListPage extends ConsumerWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsAsync = ref.watch(foodProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Food List')),
      body: foodsAsync.when(
        data: (foods) => LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                  ),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('City')),
                      DataColumn(label: Text('Rating')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: foods.map((food) {
                      final location = food.locations.isNotEmpty
                          ? food.locations.first
                          : null;
                      return DataRow(
                        cells: [
                          DataCell(SizedBox(
                            width: 200,
                            child: Text(
                              food.name,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          DataCell(SizedBox(
                            width: 100,
                            child: Text(
                              location?.city ?? 'N/A',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          DataCell(SizedBox(
                            width: 50,
                            child: Text(
                              food.rating.toStringAsFixed(1),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  MdiIcons.eye,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onPressed: () {
                                  context.goNamed('food_detail',
                                      pathParameters: {'id': food.id});
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/add_food',
                                    arguments: food,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Food'),
                                      content: const Text(
                                        'Are you sure you want to delete this food?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirmed ?? false) {
                                    try {
                                      await ref
                                          .read(foodProvider.notifier)
                                          .deleteFood(food.id);
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Food deleted successfully'),
                                        ),
                                      );
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Error deleting food: $e'),
                                        ),
                                      );
                                    }
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
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
