import 'package:flutter/material.dart';
import 'package:main/core/widgets/sidebar.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isLargeScreen
          ? null
          : AppBar(
              title: const Text('Admin Dashboard'),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
      drawer: isLargeScreen ? null : const Sidebar(),
      body: Row(
        children: [
          if (isLargeScreen) const Sidebar(),
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
