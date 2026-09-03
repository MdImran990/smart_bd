import 'package:dio/dio.dart';

import '../models/weather_model.dart';

class WeatherRemoteDatasource {
  final Dio _dio;

  static const _apiKey = '3c4d633e38eb836707ad93bb8c4bb775';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5';

  WeatherRemoteDatasource() : _dio = Dio();

  Future<WeatherModel> getWeatherByLocation({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      return WeatherModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }

  Future<WeatherModel> getWeatherByCity({
    required String city,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/weather',
        queryParameters: {
          'q': city,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      return WeatherModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }
}