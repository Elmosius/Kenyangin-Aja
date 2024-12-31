import 'package:flutter/material.dart';

class FoodDataCell extends StatelessWidget {
  final String content;
  final double width;
  final int maxLines;

  const FoodDataCell({
    super.key,
    required this.content,
    required this.width,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        content,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
