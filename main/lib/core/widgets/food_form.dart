import 'package:flutter/material.dart';

class FoodFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController imageUrlController;

  const FoodFormFields({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.imageUrlController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Food Name'),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter the food name' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
          maxLines: 3,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter the description' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: imageUrlController,
          decoration: const InputDecoration(labelText: 'Image URL'),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter the image URL' : null,
        ),
      ],
    );
  }
}
