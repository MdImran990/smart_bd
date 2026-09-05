import '../entities/weather_entity.dart';

abstract class WeatherRepositoryInterface {
  Future<WeatherEntity> getWeather();
  Future<WeatherEntity> getWeatherByCity({required String city});
}