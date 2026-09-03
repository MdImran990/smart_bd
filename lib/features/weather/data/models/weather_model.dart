class WeatherModel {
  final String city;
  final String country;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;

  const WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] as String,
      country: json['sys']['country'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}