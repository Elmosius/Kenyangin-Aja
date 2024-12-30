import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onSearch;
  const SearchBarWidget({required this.onSearch, super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    widget.onSearch(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (_) => _handleSearch(),
      decoration: InputDecoration(
        filled: true,
        hoverColor: Colors.white,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // Logika filter (jika ada)
          },
        ),
        hintText: "Cari nama tempat makan...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
