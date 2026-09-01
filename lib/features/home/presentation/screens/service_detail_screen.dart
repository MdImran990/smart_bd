import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceId;
  final String title;
  final IconData icon;

  const ServiceDetailScreen({
    super.key,
    required this.serviceId,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2563EB),
                      Color(0xFF1D4ED8),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // Quick Actions
                const Text(
                  'Quick Actions',
                  style: AppTextStyles.headingMedium,
                ),

                const SizedBox(height: AppSpacing.lg),

                Row(
                  children: [
                    _ActionButton(
                      icon: Icons.phone_outlined,
                      label: 'Call',
                      onTap: () {},
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _ActionButton(
                      icon: Icons.location_on_outlined,
                      label: 'Directions',
                      onTap: () {},
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _ActionButton(
                      icon: Icons.bookmark_outline_rounded,
                      label: 'Save',
                      onTap: () {},
                    ),
                    const SizedBox(width: AppSpacing.md),
                    _ActionButton(
                      icon: Icons.share_outlined,
                      label: 'Share',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xxxl),

                // Nearby Places
                const Text(
                  'Nearby Places',
                  style: AppTextStyles.headingMedium,
                ),

                const SizedBox(height: AppSpacing.lg),

                _NearbyPlaceCard(
                  name: '$title A',
                  address: 'Mirpur, Dhaka',
                  distance: '1.2 km',
                  rating: '4.5',
                  icon: icon,
                ),

                _NearbyPlaceCard(
                  name: '$title B',
                  address: 'Dhanmondi, Dhaka',
                  distance: '2.1 km',
                  rating: '4.2',
                  icon: icon,
                ),

                _NearbyPlaceCard(
                  name: '$title C',
                  address: 'Gulshan, Dhaka',
                  distance: '3.5 km',
                  rating: '4.8',
                  icon: icon,
                ),

                _NearbyPlaceCard(
                  name: '$title D',
                  address: 'Banani, Dhaka',
                  distance: '4.0 km',
                  rating: '4.1',
                  icon: icon,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NearbyPlaceCard extends StatelessWidget {
  final String name;
  final String address;
  final String distance;
  final String rating;
  final IconData icon;

  const _NearbyPlaceCard({
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 22,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: Color(0xFFF59E0B),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    rating,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                distance,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}