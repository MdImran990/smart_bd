import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/weather_model.dart';
import '../../data/repositories/weather_repository.dart';

// Repository Provider
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

// Weather Status
enum WeatherStatus { initial, loading, success, error }

// Weather State
class WeatherState {
  final WeatherStatus status;
  final WeatherModel? weather;
  final String? errorMessage;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.errorMessage,
  });

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherModel? weather,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Weather Notifier
class WeatherNotifier extends Notifier<WeatherState> {
  @override
  WeatherState build() {
    fetchWeather();
    return const WeatherState(status: WeatherStatus.loading);
  }

  Future<void> fetchWeather() async {
    state = const WeatherState(status: WeatherStatus.loading);

    try {
      final repository = ref.read(weatherRepositoryProvider);
      final weather = await repository.getWeather();
      state = WeatherState(
        status: WeatherStatus.success,
        weather: weather,
      );
    } catch (e) {
      state = WeatherState(
        status: WeatherStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}

// Provider
final weatherProvider =
NotifierProvider<WeatherNotifier, WeatherState>(() {
  return WeatherNotifier();
});