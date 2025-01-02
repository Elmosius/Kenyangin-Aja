import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/core/widgets/sidebar_item.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authStateNotifierProvider.notifier);
    final mediaQuery = MediaQuery.of(context);
    final currentRoute = GoRouterState.of(context).uri.toString();

    final double sidebarWidth = mediaQuery.size.width > 600 ? 250 : 200;

    return Container(
      width: sidebarWidth,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Color(0xFFDE9151),
            Color(0xFFF5F5F5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(Icons.person, color: AppColors.hitam),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Admin Dashboard',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Menu Items
          SidebarItem(
            icon: MdiIcons.home,
            title: 'Dashboard',
            isActive: currentRoute == '/dashboard',
            onTap: () => context.goNamed('dashboard'),
          ),
          SidebarItem(
            icon: Icons.api,
            title: 'Search',
            isActive: currentRoute == '/dashboard/search',
            onTap: () => context.goNamed('search'),
          ),
          SidebarItem(
            icon: Icons.tiktok,
            title: 'Tiktok Ref',
            isActive: currentRoute == '/dashboard/list-tiktok',
            onTap: () => context.goNamed('list-tiktok'),
          ),
          SidebarItem(
            icon: MdiIcons.food,
            title: 'Foods',
            isActive: currentRoute == '/dashboard/list-food',
            onTap: () => context.goNamed('list-food'),
          ),
          SidebarItem(
            icon: Icons.add,
            title: 'Add Food',
            isActive: currentRoute == '/dashboard/add-food',
            onTap: () => context.goNamed('add-food'),
          ),
          const Divider(color: Colors.white70, thickness: 1),
          SidebarItem(
            icon: Icons.undo,
            title: 'Back to Home',
            onTap: () async {
              context.goNamed('home');
            },
          ),
          SidebarItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () async {
              await authNotifier.logout();
              if (!context.mounted) return;
              context.goNamed('login');
            },
          ),
        ],
      ),
    );
  }
}
