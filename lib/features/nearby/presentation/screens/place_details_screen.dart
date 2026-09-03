import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../data/models/nearby_place_model.dart';
import '../providers/nearby_provider.dart';

class PlaceDetailsScreen extends ConsumerWidget {
  final NearbyPlaceModel place;

  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritePlacesProvider);
    final isFavorite = favorites.contains(place.id);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      ref
                          .read(favoritePlacesProvider.notifier)
                          .toggleFavorite(place.id);
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite
                          ? Colors.red
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Center(
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color:
                          AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          place.icon,
                          size: 55,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      place.category,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Info Cards
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      value: place.address,
                    ),

                    _InfoRow(
                      icon: Icons.directions_walk_rounded,
                      title: 'Distance',
                      value: place.distance,
                    ),

                    _InfoRow(
                      icon: Icons.star_rounded,
                      title: 'Rating',
                      value: '${place.rating} / 5.0',
                    ),

                    _InfoRow(
                      icon: place.isOpen
                          ? Icons.check_circle_outline
                          : Icons.cancel_outlined,
                      title: 'Status',
                      value: place.isOpen ? 'Open Now' : 'Closed',
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    Text(
                      '${place.name} is one of the nearby ${place.category.toLowerCase()} services available in your area.',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Directions feature coming soon!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.directions_rounded),
                  label: const Text('Get Directions'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}