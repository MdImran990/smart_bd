import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authUser = authState.user;

    final profile = ref.watch(profileProvider);

    final name = profile.name.isNotEmpty
        ? profile.name
        : authUser?.name ?? 'User';

    final email = profile.email.isNotEmpty
        ? profile.email
        : authUser?.email ?? '';

    final hasImage = profile.imagePath != null &&
        File(profile.imagePath!).existsSync();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          children: [
            const SizedBox(height: AppSpacing.md),

            // PROFILE HEADER

            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push('/edit-profile');
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(
                              alpha: 0.15,
                            ),
                            image: hasImage
                                ? DecorationImage(
                              image: FileImage(
                                File(profile.imagePath!),
                              ),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: hasImage
                              ? null
                              : const Icon(
                            Icons.person_rounded,
                            size: 60,
                            color: AppColors.primary,
                          ),
                        ),

                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              size: 19,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    email,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  OutlinedButton.icon(
                    onPressed: () {
                      context.push('/edit-profile');
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // MENU

            _ProfileMenuCard(
              children: [
                _ProfileMenuItem(
                  icon: Icons.favorite_outline_rounded,
                  title: 'My Favorites',
                  onTap: () {
                    context.push('/nearby/favorites');
                  },
                ),

                _ProfileMenuItem(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  onTap: () {
                    context.push('/notifications');
                  },
                ),

                _ProfileMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    context.push('/settings');
                  },
                ),

                _ProfileMenuItem(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  onTap: () {
                    _showSupportDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // LOGOUT

            Container(
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.error,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.error,
                ),
                onTap: () {
                  _showLogoutDialog(context, ref);
                },
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            Center(
              child: Text(
                'Smart BD v1.0.0',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(
      BuildContext context,
      WidgetRef ref,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                dialogContext.pop();
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                dialogContext.pop();

                await ref
                    .read(authProvider.notifier)
                    .logout();

                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Help & Support'),
          content: const Text(
            'For support, please contact Smart BD support team.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                dialogContext.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileMenuCard extends StatelessWidget {
  final List<Widget> children;

  const _ProfileMenuCard({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
      ),
      onTap: onTap,
    );
  }
}