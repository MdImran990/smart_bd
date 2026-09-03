import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_service_card.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(emergencyServicesProvider);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Header
              const Text(
                'Emergency',
                style: AppTextStyles.headingLarge,
              ),

              const SizedBox(height: 4),

              const Text(
                'Quick access to emergency services',
                style: AppTextStyles.bodyMedium,
              ),

              const SizedBox(height: AppSpacing.xl),

              // SOS Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFEF4444),
                      Color(0xFFDC2626),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                      offset: const Offset(0, 8),
                    ),
                  ],
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
                        Icons.sos_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    const Text(
                      'SOS Emergency',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Call National Emergency: 999',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone_rounded),
                        label: const Text(
                          'Call 999 Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFEF4444),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Emergency Services
              const Text(
                'Emergency Services',
                style: AppTextStyles.headingMedium,
              ),

              const SizedBox(height: AppSpacing.lg),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return EmergencyServiceCard(
                    service: service,
                    onTap: () {
                      context.push(
                        '/emergency/details',
                        extra: service,
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Safety Tips
              const Text(
                'Safety Tips',
                style: AppTextStyles.headingMedium,
              ),

              const SizedBox(height: AppSpacing.lg),

              _SafetyTip(
                icon: Icons.phone_rounded,
                tip: 'Save emergency numbers in your contacts',
              ),
              const SizedBox(height: AppSpacing.md),
              _SafetyTip(
                icon: Icons.location_on_rounded,
                tip: 'Always know your current location',
              ),
              const SizedBox(height: AppSpacing.md),
              _SafetyTip(
                icon: Icons.battery_full_rounded,
                tip: 'Keep your phone charged at all times',
              ),
              const SizedBox(height: AppSpacing.md),
              _SafetyTip(
                icon: Icons.people_rounded,
                tip: 'Stay calm and describe your situation clearly',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SafetyTip extends StatelessWidget {
  final IconData icon;
  final String tip;

  const _SafetyTip({required this.icon, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}