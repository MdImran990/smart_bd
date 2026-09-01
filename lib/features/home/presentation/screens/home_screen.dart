import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/service_provider.dart';
import '../widgets/service_button.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
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
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Imran',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          '📍 Dhaka, Bangladesh',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
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

              const SizedBox(height: 25),

              // Weather
              const WeatherCard(),

              const SizedBox(height: 30),

              // Services Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quick Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const Text('See all'),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Services
              Consumer(
                builder: (context, ref, _) {
                  final services = ref.watch(servicesProvider);
                  return GridView.builder(
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
                          debugPrint('Selected: ${service.title}');
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 30),

              // Nearby
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nearby Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const Text('View all'),
                  ),
                ],
              ),

              const SizedBox(height: 14),

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