import 'package:flutter/material.dart';

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
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm(controller.text);
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      );
    },
  );
}
