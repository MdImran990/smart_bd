import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
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
          padding: EdgeInsets.fromLTRB(
            Responsive.pagePadding(context).horizontal / 2,
            AppSpacing.xl,
            Responsive.pagePadding(context).horizontal / 2,
            100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning 👋',
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: 5),

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

                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
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
                ],
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Weather
              const WeatherCard(),

              const SizedBox(height: AppSpacing.xxxl),

              // Services Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quick Services',
                    style: AppTextStyles.headingMedium,
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const Text('See all'),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              // Services
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
                      context.go(
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
                    onPressed: () {},
                    child: const Text('View all'),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              SizedBox(
                height: 125,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _NearbyCard(
                      icon: Icons.local_hospital_outlined,
                      title: 'Hospital',
                      distance: '1.2 km',
                    ),

                    _NearbyCard(
                      icon: Icons.local_pharmacy_outlined,
                      title: 'Pharmacy',
                      distance: '0.8 km',
                    ),

                    _NearbyCard(
                      icon: Icons.account_balance_outlined,
                      title: 'Bank',
                      distance: '1.5 km',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NearbyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String distance;

  const _NearbyCard({
    required this.icon,
    required this.title,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            '$distance away',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}