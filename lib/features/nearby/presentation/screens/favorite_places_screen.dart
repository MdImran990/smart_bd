import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../providers/nearby_provider.dart';

class FavoritePlacesScreen extends ConsumerWidget {
  const FavoritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(nearbyPlacesProvider);
    final favoriteIds = ref.watch(favoritePlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
        centerTitle: true,
      ),
      body: placesAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stack) {
          return Center(
            child: Text('Error: $error'),
          );
        },
        data: (places) {
          final favoritePlaces = places
              .where((place) => favoriteIds.contains(place.id))
              .toList();

          if (favoritePlaces.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 70,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'No favorite places yet',
                    style: AppTextStyles.headingMedium,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'Add places to your favorites',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.xl),
            itemCount: favoritePlaces.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final place = favoritePlaces[index];

              return GestureDetector(
                onTap: () {
                  context.push(
                    '/nearby/place-details',
                    extra: place,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
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
                  child: Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          place.icon,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(width: AppSpacing.md),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.textPrimary,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              place.address,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: Colors.amber,
                                ),

                                const SizedBox(width: 4),

                                Text(
                                  place.rating,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Text(
                                  place.distance,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          ref
                              .read(favoritePlacesProvider.notifier)
                              .toggleFavorite(place.id);
                        },
                        icon: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}