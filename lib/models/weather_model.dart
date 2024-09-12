import 'dart:convert';

class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherCondition;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityName': cityName,
      'temperature': temperature,
      'weatherCondition': weatherCondition,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      cityName: map['cityName'] as String,
      temperature: map['temperature'] as double,
      weatherCondition: map['weatherCondition'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'WeatherModel(cityName: $cityName, temperature: $temperature, weatherCondition: $weatherCondition)';

}
