import 'dart:developer';

import 'package:live_weather/models/weather_model.dart';
import 'package:live_weather/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:live_weather/constants/constants.dart';

class WeatherView extends StatelessWidget {
  WeatherView({super.key});

  final weatherService = AppWeatherService();

  Future<WeatherModel?> fetchWeather() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: fetchWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(getWeatherAnimation(snapshot.data?.weatherCondition)),
                  Text(snapshot.data?.weatherCondition ?? "Loading weather condition ..."),
                  Text(snapshot.data?.cityName ?? "Loading city ..."),
                  Text(
                      "${snapshot.data?.temperature.round() ?? "Loading Temparature ..."}°C")
                ],
              );
            }
          }),
    ));
  }
}
