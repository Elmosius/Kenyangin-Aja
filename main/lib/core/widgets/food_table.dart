import 'package:flutter/material.dart';
import 'package:main/core/widgets/food_actions.dart';
import 'package:main/core/widgets/food_cell.dart';
import 'package:main/features/admin/views/food_list_page.dart';

class FoodListTable extends StatelessWidget {
  final List<dynamic> foods;

  const FoodListTable({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                  final location =
                      food.locations.isNotEmpty ? food.locations.first : null;

                  return DataRow(
                    cells: [
                      DataCell(FoodDataCell(
                        content: food.name,
                        width: 200,
                        maxLines: 4,
                      )),
                      DataCell(FoodDataCell(
                        content: location?.city ?? 'N/A',
                        width: 100,
                        maxLines: 2,
                      )),
                      DataCell(FoodDataCell(
                        content: food.rating.toStringAsFixed(1),
                        width: 50,
                        maxLines: 1,
                      )),
                      DataCell(FoodActionButtons(foodId: food.id)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
