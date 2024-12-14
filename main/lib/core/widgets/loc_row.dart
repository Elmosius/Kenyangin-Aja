import 'package:flutter/material.dart';

class LocationRow extends StatelessWidget {
  final Map<String, String> location;
  final VoidCallback onRemove;

  const LocationRow({
    super.key,
    required this.location,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: location['city'],
              decoration: const InputDecoration(labelText: 'City'),
              onChanged: (value) => location['city'] = value,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              initialValue: location['address'],
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (value) => location['address'] = value,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              initialValue: location['url'],
              decoration: const InputDecoration(labelText: 'URL'),
              onChanged: (value) => location['url'] = value,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
