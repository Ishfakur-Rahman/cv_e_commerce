import 'dart:developer';

import 'package:cv_e_commerce/models/weather_model.dart';
import 'package:cv_e_commerce/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
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
    if (mainCondition == null) return "assets/sunny_weather.json";
    switch (mainCondition.toLowerCase()) {
      case "clouds":
        return "assets/coudy_weather.json";
      case "rain":
        return "assets/rainy_weather.josn";
      case "clear":
        return "assets/sunny_weather.json";
      case "thunderstorm":
        return 'assets/rainy_and_stormy_weather.json';
      default:
        return "assets/sunny_weather.json";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
