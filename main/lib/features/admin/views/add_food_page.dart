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
      appBar: AppBar(
        title: Text(
          'Add Food',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
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
                if (_selectedTikTokRef != null)
                  TikTokPreview(tiktokRef: _selectedTikTokRef!),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topRight,
                  child: SubmitButton(
                    formKey: _formKey,
                    onSubmit: () async {
                      if (_formKey.currentState?.validate() != true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please fill in all required fields.'),
                          ),
                        );
                        return;
                      }
                      if (_locations.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please add at least one location.'),
                          ),
                        );
                        return;
                      }
                      final food = Food(
                        id: '',
                        name: _nameController.text,
                        description: _descriptionController.text,
                        locations: _locations.map((loc) {
                          return Location(
                            city: loc['city'] ?? '',
                            address: loc['address'] ?? '',
                            url: loc['url'] ?? '',
                          );
                        }).toList(),
                        imageUrl: _imageUrlController.text,
                        rating: 0.0,
                        tiktokRef: _selectedTikTokRef,
                        createdAt: DateTime.now(),
                      );

                      await ref.read(foodProvider.notifier).addFood(food);
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}
