import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/food_form.dart';
import 'package:main/core/widgets/loc_list.dart';
import 'package:main/core/widgets/submit_button.dart';
import 'package:main/core/widgets/tiktok_dropdown.dart';
import 'package:main/core/widgets/tiktok_preview.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/models/location.dart';
import 'package:main/data/providers/food_provider.dart';

class EditFoodPage extends ConsumerStatefulWidget {
  final String foodId;

  const EditFoodPage({super.key, required this.foodId});

  @override
  ConsumerState<EditFoodPage> createState() => _EditFoodPageState();
}

class _EditFoodPageState extends ConsumerState<EditFoodPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  List<Map<String, String>> _locations = [];
  String? _selectedTikTokRef;

  void _loadFoodData(Food food) {
    _nameController.text = food.name;
    _descriptionController.text = food.description;
    _imageUrlController.text = food.imageUrl;
    _locations = food.locations
        .map((location) => {
              'city': location.city,
              'address': location.address,
              'url': location.url ?? '',
            })
        .toList();
    _selectedTikTokRef = food.tiktokRef;
  }

  Future<void> _updateFood() async {
    final updatedFood = Food(
      id: widget.foodId,
      name: _nameController.text,
      description: _descriptionController.text,
      locations: _locations
          .map((loc) => Location(
                city: loc['city'] ?? '',
                address: loc['address'] ?? '',
                url: loc['url'],
              ))
          .toList(),
      imageUrl: _imageUrlController.text,
      rating: 0.0,
      tiktokRef: _selectedTikTokRef,
    );

    try {
      await ref
          .read(foodProvider.notifier)
          .updateFood(widget.foodId, updatedFood);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Food updated successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update food: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodAsync = ref.watch(foodDetailProvider(widget.foodId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Food',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: foodAsync.when(
        data: (food) {
          if (_nameController.text.isEmpty) {
            _loadFoodData(food);
          }

          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form Fields
                    FoodFormFields(
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      imageUrlController: _imageUrlController,
                      isEditMode: true, // Indikasi untuk edit mode
                    ),
                    const SizedBox(height: 16),

                    // Location List
                    LocationList(
                      locations: _locations,
                      onAddLocation: (location) {
                        setState(() {
                          _locations.add(location);
                        });
                      },
                      onRemoveLocation: (index) {
                        setState(() {
                          _locations.removeAt(index);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Reference',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TikTokDropdown(
                      selectedTikTokRef: _selectedTikTokRef,
                      onChanged: (value) => setState(() {
                        _selectedTikTokRef = value;
                      }),
                    ),
                    const SizedBox(height: 16),

                    // TikTok Preview
                    if (_selectedTikTokRef != null)
                      TikTokPreview(tiktokRef: _selectedTikTokRef!),
                    const SizedBox(height: 16),

                    // Submit Button
                    Align(
                      alignment: Alignment.topRight,
                      child: SubmitButton(
                        formKey: _formKey,
                        onSubmit: _updateFood,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading food: $error'),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}
