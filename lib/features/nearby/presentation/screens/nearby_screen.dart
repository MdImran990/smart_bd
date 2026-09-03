import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../providers/nearby_provider.dart';

class NearbyScreen extends ConsumerWidget {
  const NearbyScreen({super.key});

  static const List<String> filters = [
    'All',
    'Hospital',
    'Pharmacy',
    'Bank',
    'Police',
    'Fire Service',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(nearbyPlacesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context, ref),

            const SizedBox(height: AppSpacing.md),

            // Filters
            _buildFilters(ref, selectedCategory),

            const SizedBox(height: AppSpacing.lg),

            // Places
            Expanded(
              child: placesAsync.when(
                loading: () =>
                const Center(child: CircularProgressIndicator()),

                error: (error, stack) =>
                    Center(child: Text('Error: $error')),

                data: (places) {
                  final filteredPlaces = places.where((place) {
                    final matchesCategory =
                        selectedCategory == 'All' ||
                            place.category == selectedCategory;

                    final query = searchQuery.toLowerCase();

                    final matchesSearch =
                        place.name.toLowerCase().contains(query) ||
                            place.address.toLowerCase().contains(query) ||
                            place.category.toLowerCase().contains(query);

                    return matchesCategory && matchesSearch;
                  }).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                        child: Text(
                          '${filteredPlaces.length} places found',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      Expanded(
                        child: filteredPlaces.isEmpty
                            ? const Center(
                          child: Text(
                            'No places found',
                            style: AppTextStyles.bodyMedium,
                          ),
                        )
                            : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.xl,
                            0,
                            AppSpacing.xl,
                            100,
                          ),
                          itemCount: filteredPlaces.length,
                          separatorBuilder: (_, index) =>
                          const SizedBox(
                            height: AppSpacing.md,
                          ),
                          itemBuilder: (context, index) {
                            final place = filteredPlaces[index];

                            return _PlaceCard(
                              place: place,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Favorite Button
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Nearby Services',
                  style: AppTextStyles.headingLarge,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withValues(alpha: 0.05),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    context.push('/nearby/favorites');
                  },
                  icon: const Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            '📍 Dhaka, Bangladesh',
            style: AppTextStyles.bodyMedium,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Search Bar
          Container(
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
            child: TextField(
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                hintText: 'Search nearby services...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= FILTERS =================

  Widget _buildFilters(
      WidgetRef ref,
      String selectedCategory,
      ) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
        ),
        itemCount: filters.length,
        separatorBuilder: (_, index) =>
        const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedCategory == filter;

          return GestureDetector(
            onTap: () {
              ref.read(selectedCategoryProvider.notifier).state =
                  filter;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ],
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= PLACE CARD =================

class _PlaceCard extends ConsumerWidget {
  final dynamic place;

  const _PlaceCard({
    required this.place,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritePlacesProvider);

    final isFavorite = favorites.contains(place.id);

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
            // Icon
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

            // Information
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Colors.amber.shade700,
                      ),

                      const SizedBox(width: 3),

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

            // Favorite + Status
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                        : AppColors.textSecondary,
                  ),
                ),

                Text(
                  place.isOpen ? 'Open' : 'Closed',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: place.isOpen
                        ? AppColors.success
                        : AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}