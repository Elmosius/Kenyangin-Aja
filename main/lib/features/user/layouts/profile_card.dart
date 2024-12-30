import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/edit_dialog.dart';
import 'package:main/core/widgets/profile_card.dart';
import 'package:main/data/providers/auth_state_notifier.dart';

class ProfileCardSection extends ConsumerWidget {
  final String userName;
  final String userEmail;
  final String userId;

  const ProfileCardSection({
    required this.userName,
    required this.userEmail,
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProfileCard(
      userName: userName,
      userEmail: userEmail,
      onEditName: () async {
        await showEditDialog(
          context: context,
          title: "Masukkan nama baru ",
          initialValue: userName,
          onConfirm: (newName) async {
            await ref
                .read(authStateNotifierProvider.notifier)
                .updateUserProfile(
              userId: userId,
              updates: {'name': newName},
            );
          },
        );
      },
      onEditEmail: () async {
        await showEditDialog(
          context: context,
          title: "Masukan email baru",
          initialValue: userEmail,
          onConfirm: (newEmail) async {
            await ref
                .read(authStateNotifierProvider.notifier)
                .updateUserProfile(
              userId: userId,
              updates: {'email': newEmail},
            );
          },
        );
      },
    );
  }
}
