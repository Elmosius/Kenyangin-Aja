import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authStateNotifierProvider.notifier);
    final mediaQuery = MediaQuery.of(context);

    final double sidebarWidth = mediaQuery.size.width > 600 ? 250 : 200;

    return Container(
      width: sidebarWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Admin Menu',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: Colors.black54, thickness: 1),
          SidebarItem(
            icon: MdiIcons.home,
            title: 'Dashboard',
            onTap: () => context.goNamed('dashboard'),
          ),
          SidebarItem(
            icon: MdiIcons.food,
            title: 'Food List',
            onTap: () => context.goNamed('list_food'),
          ),
          SidebarItem(
            icon: Icons.add,
            title: 'Add Food',
            onTap: () => context.goNamed('add_food'),
          ),
          SidebarItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () async {
              await authNotifier.logout();
              if (!context.mounted) return;
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 20,
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
