import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),

        children: [
          const Text(
            'Appearance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),

            child: SwitchListTile(
              title: const Text('Dark Mode'),

              subtitle: Text(
                isDarkMode
                    ? 'Dark theme is enabled'
                    : 'Light theme is enabled',
              ),

              secondary: Icon(
                isDarkMode
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
              ),

              value: isDarkMode,

              onChanged: (value) {
                ref.read(themeProvider.notifier).state =
                value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),

          const SizedBox(height: AppSpacing.xxl),

          const Text(
            'Application',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),

            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: const Text('Language'),
                  subtitle: const Text('English'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text('About Smart BD'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Smart BD',
                      applicationVersion: '1.0.0',
                      applicationLegalese: 'Smart Bangladesh Service Hub',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}