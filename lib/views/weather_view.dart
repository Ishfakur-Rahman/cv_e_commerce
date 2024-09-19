import 'package:flutter/material.dart';
import 'package:live_weather/models/weather_model.dart';
import 'package:live_weather/utils/weather_condition_provider.dart';
import 'package:lottie/lottie.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

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
              return MainContent(
                weatherModel: snapshot.data,
              );
            }
          }),
    ));
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
    this.weatherModel,
  });

  final WeatherModel? weatherModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TodayWeatherContent(weatherModel: weatherModel),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) => Container(
              color: const Color(0x7524E6BB),
              height: 20,
              margin: const EdgeInsets.all(2),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Lottie.asset(
                        getWeatherAnimation(weatherModel?.weatherCondition)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (weatherModel!.temperature.round()).toString(),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(weatherModel!.cityName),
                        Text(
                          weatherModel!.weatherCondition,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayWeatherContent extends StatelessWidget {
  const TodayWeatherContent({
    super.key,
    required this.weatherModel,
  });

  final WeatherModel? weatherModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(getWeatherAnimation(weatherModel?.weatherCondition)),
          Text(weatherModel?.weatherCondition ??
              "Loading weather condition ..."),
          const Spacer(),
          Text(
            "${weatherModel?.temperature.round() ?? "Loading Temparature ..."}°C",
            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w500),
          ),
          Text(
            weatherModel?.cityName ?? "Loading city ...",
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
          ),
          const Spacer(
            flex: 8,
          ),
        ],
      ),
    );
  }
}
