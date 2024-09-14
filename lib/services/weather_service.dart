import 'package:live_weather/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_pack/weather_pack.dart';

class AppWeatherService {
  static const String kBaseUrl = "http://openweathermap.org/data/2.5/weather";
  static const String apiKey = "0833d56f8f0a9f8f5e002d8711f07e95";
  static final WeatherService _weatherService = WeatherService(apiKey);
  static final GeocodingService _geocodingService = GeocodingService(apiKey);

  late double _latitude;
  late double _longitude;

  Future<bool> get _permissionIsGranted async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<WeatherModel> getWeather() async {
    await _updateCurrentLocation();
    WeatherCurrent currentWeather = await _weatherService
        .currentWeatherByLocation(latitude: _latitude, longitude: _longitude);
    // log(currentWeather.toJson().toString());
    return await _mapWeatherToModel(currentWeather);
  }

  Future<void> _updateCurrentLocation() async {
    if (!await _permissionIsGranted) {
      await Geolocator.openAppSettings();
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );
    _latitude = position.latitude;
    _longitude = position.longitude;
  }

  Future<WeatherModel> _mapWeatherToModel(
          WeatherCurrent currentWeather) async =>
      WeatherModel(
          cityName: await _getCurrentCity(),
          temperature: _convertToCelcius(currentWeather.toJson()["temp"]),
          weatherCondition: currentWeather.toJson()["weather"][0]
              ["description"]);

  Future<String> _getCurrentCity() async {
    List<PlaceGeocode> places = await _geocodingService
        .getLocationByCoordinates(latitude: _latitude, longitude: _longitude);

    return places.isNotEmpty ? places[0].name ?? "" : "";
  }

  double _convertToCelcius(double tempFahrenheit) =>
      tempFahrenheit - 273.15;
}
