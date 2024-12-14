import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/food_form.dart';
import 'package:main/core/widgets/loc_list.dart';
import 'package:main/core/widgets/submit_button.dart';
import 'package:main/core/widgets/tiktok_dropdown.dart';
import 'package:main/core/widgets/tiktok_preview.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/models/location.dart';
import 'package:main/data/providers/food_provider.dart';

class AddFoodPage extends ConsumerStatefulWidget {
  const AddFoodPage({super.key});

  @override
  ConsumerState<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends ConsumerState<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final List<Map<String, String>> _locations = [];
  String? _selectedTikTokRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Food')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodFormFields(
                  nameController: _nameController,
                  descriptionController: _descriptionController,
                  imageUrlController: _imageUrlController,
                ),
                const SizedBox(height: 16),
                LocationList(
                  locations: _locations,
                  onAddLocation: (newLocation) {
                    setState(() => _locations.add(newLocation));
                  },
                  onRemoveLocation: (index) {
                    setState(() => _locations.removeAt(index));
                  },
                ),
                const SizedBox(height: 16),
                TikTokDropdown(
                  selectedTikTokRef: _selectedTikTokRef,
                  onChanged: (value) => setState(() {
                    _selectedTikTokRef = value;
                  }),
                ),
                const SizedBox(height: 16),
                if (_selectedTikTokRef != null)
                  TikTokPreview(tiktokRef: _selectedTikTokRef!),
                const SizedBox(height: 16),
                SubmitButton(
                  formKey: _formKey,
                  onSubmit: () async {
                    final food = Food(
                      id: '',
                      name: _nameController.text,
                      description: _descriptionController.text,
                      locations: _locations.map((loc) {
                        return Location(
                          city: loc['city']!,
                          address: loc['address']!,
                          url: loc['url'],
                        );
                      }).toList(),
                      imageUrl: _imageUrlController.text,
                      rating: 0.0,
                      tiktokRef: _selectedTikTokRef,
                    );

                    await ref.read(foodProvider.notifier).addFood(food);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
