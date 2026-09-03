import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../providers/service_provider.dart';
import '../widgets/service_button.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
            110,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Header
              _buildHeader(context),

              const SizedBox(height: AppSpacing.xxl),

              // Weather
              const WeatherCard(),

              const SizedBox(height: AppSpacing.xxxl),

              // Quick Services Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quick Services',
                    style: AppTextStyles.headingMedium,
                  ),
                  TextButton(
                    onPressed: () => context.go('/nearby'),
                    child: const Text('See all'),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              // Services Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ServiceButton(
                    icon: service.icon,
                    title: service.title,
                    onTap: () {
                      context.push(
                        '/home/service/${service.id}',
                        extra: service,
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // Nearby Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nearby Services',
                    style: AppTextStyles.headingMedium,
                  ),
                  TextButton(
                    onPressed: () => context.go('/nearby'),
                    child: const Text('View all'),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              // Nearby Cards
              SizedBox(
                height: 135,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _NearbyCard(
                      icon: Icons.local_hospital_outlined,
                      title: 'Hospital',
                      distance: 'Find nearby',
                      onTap: () => context.go('/nearby'),
                    ),
                    _NearbyCard(
                      icon: Icons.local_pharmacy_outlined,
                      title: 'Pharmacy',
                      distance: 'Find nearby',
                      onTap: () => context.go('/nearby'),
                    ),
                    _NearbyCard(
                      icon: Icons.account_balance_outlined,
                      title: 'Bank',
                      distance: 'Find nearby',
                      onTap: () => context.go('/nearby'),
                    ),
                    _NearbyCard(
                      icon: Icons.local_police_outlined,
                      title: 'Police',
                      distance: 'Emergency',
                      onTap: () => context.go('/nearby'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // Emergency Card ✅ navigate to /emergency
              _EmergencyCard(
                onTap: () => context.push('/emergency'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning 👋',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 4),
              const Text(
                'Imran',
                style: AppTextStyles.headingLarge,
              ),
              const SizedBox(height: 5),
              Text(
                '📍 Dhaka, Bangladesh',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),

        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => context.push('/notifications'),
            child: Ink(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.black.withValues(alpha: 0.06),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NearbyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String distance;
  final VoidCallback onTap;

  const _NearbyCard({
    required this.icon,
    required this.title,
    required this.distance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black.withValues(alpha: 0.05),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              distance,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  final VoidCallback onTap;

  const _EmergencyCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.emergency_rounded,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emergency Service',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Quick access to emergency services',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}