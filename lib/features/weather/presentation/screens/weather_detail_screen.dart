import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../data/models/weather_model.dart';
import '../providers/weather_provider.dart';

class WeatherDetailScreen extends ConsumerWidget {
  const WeatherDetailScreen({super.key});

  String _getWeatherEmoji(String icon) {
    if (icon.contains('01')) return '☀️';
    if (icon.contains('02')) return '⛅';
    if (icon.contains('03') || icon.contains('04')) return '☁️';
    if (icon.contains('09') || icon.contains('10')) return '🌧️';
    if (icon.contains('11')) return '⛈️';
    if (icon.contains('13')) return '❄️';
    if (icon.contains('50')) return '🌫️';
    return '🌤️';
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);

    if (weatherState.status == WeatherStatus.loading ||
        weatherState.status == WeatherStatus.initial) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (weatherState.status == WeatherStatus.error) {
      return Scaffold(
        appBar: AppBar(title: const Text('Weather')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_off_rounded,
                size: 60,
                color: AppColors.error,
              ),
              const SizedBox(height: 12),
              Text(
                weatherState.errorMessage ?? 'Failed to load',
                style: const TextStyle(color: AppColors.error),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    ref.read(weatherProvider.notifier).fetchWeather(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final weather = weatherState.weather!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xFF4A90D9),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4A90D9),
                      Color(0xFF357ABD),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      Text(
                        _getWeatherEmoji(weather.icon),
                        style: const TextStyle(fontSize: 70),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${weather.city}, ${weather.country}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '${weather.temperature.round()}°C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        _capitalize(weather.description),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 18,
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

                // Weather Details
                const Text(
                  'Weather Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.6,
                  children: [
                    _DetailCard(
                      icon: Icons.thermostat_rounded,
                      iconColor: const Color(0xFFEF4444),
                      label: 'Feels Like',
                      value: '${weather.feelsLike.round()}°C',
                    ),
                    _DetailCard(
                      icon: Icons.water_drop_rounded,
                      iconColor: const Color(0xFF3B82F6),
                      label: 'Humidity',
                      value: '${weather.humidity}%',
                    ),
                    _DetailCard(
                      icon: Icons.air_rounded,
                      iconColor: const Color(0xFF10B981),
                      label: 'Wind Speed',
                      value: '${weather.windSpeed} m/s',
                    ),
                    _DetailCard(
                      icon: Icons.location_on_rounded,
                      iconColor: const Color(0xFF8B5CF6),
                      label: 'Location',
                      value: weather.city,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),

                // Conditions
                const Text(
                  'Conditions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                _ConditionCard(
                  icon: Icons.water_drop_rounded,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Humidity',
                  value: '${weather.humidity}%',
                  description: weather.humidity > 70
                      ? 'High humidity — feels muggy'
                      : weather.humidity > 40
                      ? 'Comfortable humidity level'
                      : 'Low humidity — dry air',
                  progress: weather.humidity / 100,
                  progressColor: const Color(0xFF3B82F6),
                ),

                const SizedBox(height: AppSpacing.md),

                _ConditionCard(
                  icon: Icons.air_rounded,
                  iconColor: const Color(0xFF10B981),
                  title: 'Wind Speed',
                  value: '${weather.windSpeed} m/s',
                  description: weather.windSpeed > 10
                      ? 'Strong wind — be careful outdoors'
                      : weather.windSpeed > 5
                      ? 'Moderate breeze'
                      : 'Light wind — calm conditions',
                  progress: (weather.windSpeed / 20).clamp(0.0, 1.0),
                  progressColor: const Color(0xFF10B981),
                ),

                const SizedBox(height: AppSpacing.md),

                _ConditionCard(
                  icon: Icons.thermostat_rounded,
                  iconColor: const Color(0xFFEF4444),
                  title: 'Temperature',
                  value: '${weather.temperature.round()}°C',
                  description: weather.temperature > 35
                      ? 'Very hot — stay hydrated'
                      : weather.temperature > 25
                      ? 'Warm and pleasant'
                      : weather.temperature > 15
                      ? 'Cool and comfortable'
                      : 'Cold — wear warm clothes',
                  progress: (weather.temperature / 50).clamp(0.0, 1.0),
                  progressColor: const Color(0xFFEF4444),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Refresh Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        ref.read(weatherProvider.notifier).fetchWeather(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text(
                      'Refresh Weather',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90D9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _DetailCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String description;
  final double progress;
  final Color progressColor;

  const _ConditionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.description,
    required this.progress,
    required this.progressColor,
  });

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: progressColor.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}