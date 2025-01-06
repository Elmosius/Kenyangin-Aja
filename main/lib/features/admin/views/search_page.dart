import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/core/widgets/submit_button.dart';
import 'package:main/data/providers/tiktok_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _queryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedSource = "TikTok";
  String? _currentQuery;

  @override
  Widget build(BuildContext context) {
    final searchResultsAsync = _currentQuery != null
        ? ref.watch(searchTikTokProvider(_currentQuery!))
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Page',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown for Source
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                value: _selectedSource,
                decoration: const InputDecoration(labelText: "Select Source"),
                items: ["TikTok"].map((source) {
                  return DropdownMenuItem(
                    value: source,
                    child: Text(source),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSource = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Search Query Input
              TextFormField(
                controller: _queryController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.hijauTua),
                  ),
                  labelText: "Search Query",
                  labelStyle: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  border: const OutlineInputBorder(),
                  hoverColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Search query cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Submit Button (Search)
              Align(
                alignment: Alignment.centerRight,
                child: SubmitButton(
                  formKey: _formKey,
                  onSubmit: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _currentQuery = _queryController.text.trim();
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Search Results
              if (searchResultsAsync != null)
                Expanded(
                  child: searchResultsAsync.when(
                    data: (results) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Results: ${results.length}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                final result = results[index];
                                return ListTile(
                                  title: Text(result.creator.name),
                                  subtitle: Text(result.description),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) {
                      return Text(
                        'Error: $error',
                        style: const TextStyle(color: Colors.red),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}
