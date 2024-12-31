import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

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
          // City Field
          Expanded(
            child: TextFormField(
              initialValue: location['city'],
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'Enter city name',
                labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.hijauTua),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => location['city'] = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'City cannot be empty!' : null,
            ),
          ),
          const SizedBox(width: 8),

          // Address Field
          Expanded(
            child: TextFormField(
              initialValue: location['address'],
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter address',
                labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.hijauTua),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => location['address'] = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Address cannot be empty!' : null,
            ),
          ),
          const SizedBox(width: 8),

          // URL Field
          Expanded(
            child: TextFormField(
              initialValue: location['url'],
              decoration: InputDecoration(
                labelText: 'URL',
                hintText: 'Enter map link',
                labelStyle: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.hijauTua),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.link, color: AppColors.hijauTua),
              ),
              onChanged: (value) => location['url'] = value,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'URL cannot be empty!' : null,
            ),
          ),
          const SizedBox(width: 8),

          // Delete Button
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
