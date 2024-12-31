import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:main/core/widgets/food_actions.dart';
import 'package:main/core/widgets/food_cell.dart';

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
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey[200]!),
                dataRowColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.selected)
                        ? Colors.grey[300]!
                        : Colors.white),
                columnSpacing: 16,
                horizontalMargin: 16,
                border: TableBorder.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'Name',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'City',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Created At',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
                rows: foods.asMap().entries.map((entry) {
                  final index = entry.key;
                  final food = entry.value;
                  final location =
                      food.locations.isNotEmpty ? food.locations.first : null;

                  final String formattedDate = _formatDate(food.createdAt);

                  return DataRow(
                    color: MaterialStateColor.resolveWith((states) =>
                        index.isEven ? Colors.grey[50]! : Colors.white),
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
                        content: formattedDate,
                        width: 150,
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

  String _formatDate(dynamic createdAt) {
    try {
      // Check if the `createdAt` is already a DateTime or a String
      final date = createdAt is DateTime
          ? createdAt
          : DateTime.parse(createdAt as String);
      final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
      return formatter.format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }
}
