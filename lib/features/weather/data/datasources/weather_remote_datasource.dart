import 'package:dio/dio.dart';

import '../models/weather_model.dart';

class WeatherRemoteDatasource {
  final Dio _dio;
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5';

  static const String _apiKey = '3c4d633e38eb836707ad93bb8c4bb775';

  WeatherRemoteDatasource()
      : _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

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
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to fetch weather');
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
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to fetch weather');
    }
  }

  String _getDioErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';

      case DioExceptionType.receiveTimeout:
        return 'Server response timeout';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode == 401) {
          return 'Invalid Weather API Key';
        }

        if (statusCode == 404) {
          return 'City not found';
        }

        return 'Failed to load weather data';

      default:
        return 'Something went wrong';
    }
  }
}