import 'dart:developer';

import 'package:live_weather/models/weather_model.dart';
import 'package:live_weather/services/weather_service.dart';
import 'package:live_weather/utils/constants/constants.dart';

Future<WeatherModel?> fetchWeather() async {
  final weatherService = AppWeatherService();
  
    late WeatherModel weather;
    try {
      weather = await weatherService.getWeather();
    } catch (e) {
      log(e.toString());
    }
    return weather;
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return sunnyLottie;

    } else if (mainCondition.contains('clouds')) {
      return cloudyLottie;

    } else if (mainCondition.contains('rain')) {
      return rainyLottie;

    } else if (mainCondition.contains('clear')) {
      return sunnyLottie;

    } else if (mainCondition.contains('thunderstorm')) {
      return stormyLottie;
      
    } else {
      return sunnyLottie;
    }
  }