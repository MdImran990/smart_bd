import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../data/models/nearby_place_model.dart';
import '../providers/nearby_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(nearbyPlacesProvider);
    final favorites = ref.watch(favoritePlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
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
            child: Text('Something went wrong: $error'),
          );
        },
        data: (places) {
          final favoritePlaces = places
              .where((place) => favorites.contains(place.id))
              .toList();

          if (favoritePlaces.isEmpty) {
            return const _EmptyFavorites();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.xl),
            itemCount: favoritePlaces.length,
            separatorBuilder: (_, index) =>
            const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final place = favoritePlaces[index];

              return _FavoriteCard(place: place);
            },
          );
        },
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 80,
              color: AppColors.primary.withValues(alpha: 0.5),
            ),

            const SizedBox(height: AppSpacing.xl),

            const Text(
              'No Favorites Yet',
              style: AppTextStyles.headingMedium,
            ),

            const SizedBox(height: AppSpacing.sm),

            const Text(
              'Save your favorite places to quickly find them later.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: AppSpacing.xl),

            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Explore Nearby Services'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteCard extends ConsumerWidget {
  final NearbyPlaceModel place;

  const _FavoriteCard({
    required this.place,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    place.address,
                    style: AppTextStyles.bodyMedium,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    place.distance,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
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
  }
}