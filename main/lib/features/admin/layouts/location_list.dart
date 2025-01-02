import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/data/models/location.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationList extends StatelessWidget {
  final List<Location> locations;

  const LocationList({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) return const Text('No locations available.');

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < locations.length; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${i + 1}. ",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_city, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              locations[i].city,
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.place, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              locations[i].address,
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (locations[i].url != null &&
                            locations[i].url!.isNotEmpty)
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrl(
                                  Uri.parse(locations[i].url!))) {
                                await launchUrl(Uri.parse(locations[i].url!));
                              }
                            },
                            child: const Text(
                              'Visit Location',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blueAccent,
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
