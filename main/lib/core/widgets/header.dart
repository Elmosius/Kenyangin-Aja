import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/data/providers/city_provider.dart';

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget(
      {super.key,
      required String selectedLocation,
      required Null Function(dynamic value) onLocationChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(cityProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Icon(
            Icons.location_pin,
            color: AppColors.hitam,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: DropdownButton<String>(
            value: selectedCity,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            dropdownColor: Colors.white,
            items: const [
              DropdownMenuItem(value: "Bandung", child: Text("Bandung")),
              DropdownMenuItem(value: "Jakarta", child: Text("Jakarta")),
              DropdownMenuItem(value: "Surabaya", child: Text("Surabaya")),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(cityProvider.notifier).setCity(value);
              }
            },
            underline: Container(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
