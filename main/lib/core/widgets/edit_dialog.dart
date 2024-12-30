import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

Future<void> showEditDialog({
  required BuildContext context,
  required String title,
  required String initialValue,
  required ValueChanged<String> onConfirm,
}) async {
  final TextEditingController controller =
      TextEditingController(text: initialValue);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Masukkan $title baru",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal", style: GoogleFonts.inter(color: Colors.black)),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.orange),
            ),
            onPressed: () {
              onConfirm(controller.text);
              Navigator.pop(context);
            },
            child:
                Text("Simpan", style: GoogleFonts.inter(color: Colors.black)),
          ),
        ],
      );
    },
  );
}
