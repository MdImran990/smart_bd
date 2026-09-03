import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../weather/data/models/weather_model.dart';
import '../../../weather/presentation/providers/weather_provider.dart';

class WeatherCard extends ConsumerWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);

    if (weatherState.status == WeatherStatus.loading ||
        weatherState.status == WeatherStatus.initial) {
      return _LoadingCard();
    }

    if (weatherState.status == WeatherStatus.error) {
      return _ErrorCard(
        message: weatherState.errorMessage ?? 'Failed to load weather',
        onRetry: () => ref.read(weatherProvider.notifier).fetchWeather(),
      );
    }

    return _WeatherCard(weather: weatherState.weather!);
  }
}

// Loading Card
class _LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A90D9), Color(0xFF357ABD)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}

// Error Card
class _ErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorCard({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            color: AppColors.error,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(color: AppColors.error, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// Weather Card
class _WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const _WeatherCard({required this.weather});

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/weather'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A90D9), Color(0xFF357ABD)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: const Color(0xFF4A90D9).withValues(alpha: 0.3),
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  _getWeatherEmoji(weather.icon),
                  style: const TextStyle(fontSize: 32),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Temperature
            Text(
              '${weather.temperature.round()}°C',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),

            const SizedBox(height: 4),

            // Description
            Text(
              _capitalize(weather.description),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 16),

            // Extra Info
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _WeatherInfoItem(
                    icon: Icons.thermostat_rounded,
                    label: 'Feels like',
                    value: '${weather.feelsLike.round()}°C',
                  ),
                  _WeatherInfoItem(
                    icon: Icons.water_drop_rounded,
                    label: 'Humidity',
                    value: '${weather.humidity}%',
                  ),
                  _WeatherInfoItem(
                    icon: Icons.air_rounded,
                    label: 'Wind',
                    value: '${weather.windSpeed} m/s',
                  ),
                ],
              ),
            ),

            // Tap hint
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Tap for details',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}