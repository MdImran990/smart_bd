import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
            100,
          ),
          child: Column(
            children: [

              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.xxl),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2563EB),
                      Color(0xFF1D4ED8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    const Text(
                      'Imran Hossain',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '📍 Dhaka, Bangladesh',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.lg,
                    ),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(
                          label: 'Saved',
                          value: '12',
                        ),

                        const _StatDivider(),

                        _StatItem(
                          label: 'Visited',
                          value: '48',
                        ),

                        const _StatDivider(),

                        _StatItem(
                          label: 'Reviews',
                          value: '7',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              // Account Section
              const _SectionTitle(
                title: 'Account',
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              _SettingsCard(
                items: [
                  _SettingsItem(
                    icon: Icons.person_outline_rounded,
                    label: 'Edit Profile',
                    onTap: () {},
                  ),

                  _SettingsItem(
                    icon: Icons.location_on_outlined,
                    label: 'My Location',
                    onTap: () {},
                  ),

                  _SettingsItem(
                    icon: Icons.notifications_none_rounded,
                    label: 'Notifications',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              // Preferences
              const _SectionTitle(
                title: 'Preferences',
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              _SettingsCard(
                items: [
                  _SettingsItem(
                    icon: Icons.dark_mode_outlined,
                    label: 'Dark Mode',
                    onTap: () {},
                    trailing: Switch(
                      value: false,
                      onChanged: (_) {},
                    ),
                  ),

                  _SettingsItem(
                    icon: Icons.language_outlined,
                    label: 'Language',
                    onTap: () {},
                    value: 'English',
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              // Support
              const _SectionTitle(
                title: 'Support',
              ),

              const SizedBox(
                height: AppSpacing.md,
              ),

              _SettingsCard(
                items: [
                  _SettingsItem(
                    icon: Icons.help_outline_rounded,
                    label: 'Help & Support',
                    onTap: () {},
                  ),

                  _SettingsItem(
                    icon: Icons.privacy_tip_outlined,
                    label: 'Privacy Policy',
                    onTap: () {},
                  ),

                  _SettingsItem(
                    icon: Icons.info_outline_rounded,
                    label: 'About Smart BD',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.xxl,
              ),

              // =========================
              // LOGOUT BUTTON
              // =========================

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    // Show confirmation dialog
                    final shouldLogout =
                    await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text(
                            'Log Out',
                          ),
                          content: const Text(
                            'Are you sure you want to log out?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  dialogContext,
                                  false,
                                );
                              },
                              child: const Text(
                                'Cancel',
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  dialogContext,
                                  true,
                                );
                              },
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (shouldLogout != true) {
                      return;
                    }

                    // Logout from Riverpod
                    await ref
                        .read(authProvider.notifier)
                        .logout();

                    // Go to Login Page
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },

                  icon: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.error,
                  ),

                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    side: const BorderSide(
                      color: AppColors.error,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================
// STAT ITEM
// =========================

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(
              alpha: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}

// =========================
// STAT DIVIDER
// =========================

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withValues(
        alpha: 0.3,
      ),
    );
  }
}

// =========================
// SECTION TITLE
// =========================

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.headingMedium,
      ),
    );
  }
}

// =========================
// SETTINGS CARD
// =========================

class _SettingsCard extends StatelessWidget {
  final List<_SettingsItem> items;

  const _SettingsCard({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
          ),
        ],
      ),
      child: Column(
        children: items
            .asMap()
            .entries
            .map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Column(
            children: [
              item,

              if (index < items.length - 1)
                const Divider(
                  height: 1,
                  indent: 56,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// =========================
// SETTINGS ITEM
// =========================

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? value;
  final Widget? trailing;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,

      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(
            alpha: 0.10,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
      ),

      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),

      trailing: trailing ??
          (value != null
              ? Text(
            value!,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          )
              : const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: AppColors.textSecondary,
          )),
    );
  }
}