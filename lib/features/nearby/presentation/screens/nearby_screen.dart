import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Hospital',
    'Pharmacy',
    'Bank',
    'Police',
    'Fire Service',
  ];

  final List<Map<String, dynamic>> _places = [
    {
      'name': 'Dhaka Medical College Hospital',
      'category': 'Hospital',
      'distance': '1.2 km',
      'rating': '4.5',
      'address': 'Bakshibazar, Dhaka',
      'icon': Icons.local_hospital_outlined,
      'open': true,
    },
    {
      'name': 'Popular Pharmacy',
      'category': 'Pharmacy',
      'distance': '0.8 km',
      'rating': '4.3',
      'address': 'Mirpur, Dhaka',
      'icon': Icons.local_pharmacy_outlined,
      'open': true,
    },
    {
      'name': 'Dutch Bangla Bank',
      'category': 'Bank',
      'distance': '1.5 km',
      'rating': '4.1',
      'address': 'Dhanmondi, Dhaka',
      'icon': Icons.account_balance_outlined,
      'open': true,
    },
    {
      'name': 'Dhanmondi Police Station',
      'category': 'Police',
      'distance': '2.0 km',
      'rating': '3.9',
      'address': 'Dhanmondi, Dhaka',
      'icon': Icons.local_police_outlined,
      'open': true,
    },
    {
      'name': 'Square Hospital',
      'category': 'Hospital',
      'distance': '2.3 km',
      'rating': '4.7',
      'address': 'Panthapath, Dhaka',
      'icon': Icons.local_hospital_outlined,
      'open': true,
    },
    {
      'name': 'Apex Pharmacy',
      'category': 'Pharmacy',
      'distance': '0.5 km',
      'rating': '4.0',
      'address': 'Gulshan, Dhaka',
      'icon': Icons.local_pharmacy_outlined,
      'open': false,
    },
    {
      'name': 'Fire Service Station',
      'category': 'Fire Service',
      'distance': '3.1 km',
      'rating': '4.2',
      'address': 'Tejgaon, Dhaka',
      'icon': Icons.fire_truck_outlined,
      'open': true,
    },
    {
      'name': 'Islami Bank',
      'category': 'Bank',
      'distance': '1.8 km',
      'rating': '4.3',
      'address': 'Motijheel, Dhaka',
      'icon': Icons.account_balance_outlined,
      'open': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredPlaces {
    if (_selectedFilter == 'All') return _places;
    return _places
        .where((p) => p['category'] == _selectedFilter)
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nearby Services',
                    style: AppTextStyles.headingLarge,
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
                      controller: _searchController,
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
            ),

            // Filter Chips
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                ),
                itemCount: _filters.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
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
            ),

            const SizedBox(height: AppSpacing.lg),

            // Results Count
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
              ),
              child: Text(
                '${_filteredPlaces.length} places found',
                style: AppTextStyles.bodyMedium,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Places List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                ),
                itemCount: _filteredPlaces.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final place = _filteredPlaces[index];
                  return _PlaceCard(place: place);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final Map<String, dynamic> place;

  const _PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              place['icon'] as IconData,
              color: AppColors.primary,
              size: 24,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 3),

                Text(
                  place['address'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (place['open'] as bool)
                            ? AppColors.success.withValues(alpha: 0.10)
                            : AppColors.error.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        (place['open'] as bool) ? 'Open' : 'Closed',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: (place['open'] as bool)
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Icon(
                      Icons.star_rounded,
                      size: 13,
                      color: Color(0xFFF59E0B),
                    ),

                    const SizedBox(width: 2),

                    Text(
                      place['rating'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                place['distance'] as String,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.directions_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}