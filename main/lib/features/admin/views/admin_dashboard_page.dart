import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              title: Text(
                'Admin Dashboard',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: const Color(0xFFF5F5F5),
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
              color: const Color(0xFFF5F5F5),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
