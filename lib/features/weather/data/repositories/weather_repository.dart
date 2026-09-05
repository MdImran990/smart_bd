import 'package:geolocator/geolocator.dart';

import '../datasources/weather_remote_datasource.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final WeatherRemoteDatasource _datasource;

  WeatherRepository()
      : _datasource = WeatherRemoteDatasource();

  Future<WeatherModel> getWeather() async {
    try {
      final position = await _getCurrentLocation();

      return await _datasource.getWeatherByLocation(
        lat: position.latitude,
        lon: position.longitude,
      );
    } catch (_) {
      // যদি GPS কাজ না করে তাহলে Dhaka দেখাবে
      return await _datasource.getWeatherByCity(
        city: 'Dhaka',
      );
    }
  }

  Future<Position> _getCurrentLocation() async {
    final serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location service is disabled');
    }

    var permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }
}