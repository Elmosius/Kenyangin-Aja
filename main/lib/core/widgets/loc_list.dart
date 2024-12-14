import 'package:flutter/material.dart';
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
        const Text(
          'Locations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...locations.asMap().entries.map((entry) {
          final index = entry.key;
          final location = entry.value;
          return LocationRow(
            key: ValueKey(index),
            location: location,
            onRemove: () => onRemoveLocation(index),
          );
        }),
        TextButton.icon(
          onPressed: () =>
              onAddLocation({'city': '', 'address': '', 'url': ''}),
          icon: const Icon(Icons.add),
          label: const Text('Add Location'),
        ),
      ],
    );
  }
}
