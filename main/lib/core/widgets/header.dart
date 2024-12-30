import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final String selectedLocation;
  final ValueChanged<String> onLocationChanged;

  const HeaderWidget({
    required this.selectedLocation,
    required this.onLocationChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: DropdownButton<String>(
            value: selectedLocation,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            dropdownColor: Colors.white,
            items: const [
              DropdownMenuItem(
                value: "Bandung",
                child: Text("Bandung"),
              ),
              DropdownMenuItem(
                value: "Jakarta",
                child: Text("Jakarta"),
              ),
              DropdownMenuItem(
                value: "Surabaya",
                child: Text("Surabaya"),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onLocationChanged(value);
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
