import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/core/widgets/loc_row.dart';

class LocationList extends StatelessWidget {
  final List<Map<String, String>> locations;
  final void Function(Map<String, String>) onAddLocation;
  final void Function(int) onRemoveLocation;

  const LocationList({
    super.key,
    required this.locations,
    required this.onAddLocation,
    required this.onRemoveLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lokasi',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...locations.asMap().entries.map((entry) {
          final index = entry.key;
          final location = entry.value;
          return LocationRow(
            key: ValueKey(index),
            location: location,
            onRemove: () => onRemoveLocation(index),
          );
        }),
        const SizedBox(height: 16),
        TextButton.icon(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          onPressed: () =>
              onAddLocation({'city': '', 'address': '', 'url': ''}),
          icon: const Icon(Icons.add, color: AppColors.hitam),
          label: const Text(
            'Add Location',
            style: TextStyle(color: AppColors.hitam),
          ),
        ),
      ],
    );
  }
}
