import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

//provider class  manage the state of the weather data.
class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? _currentWeather;
  bool _loading = false;
  bool _noResultsFound = false;

  Weather? get currentWeather => _currentWeather;
  bool get loading => _loading;
  bool get noResultsFound => _noResultsFound;

  Future<void> fetchWeather(String cityName) async {
    _loading = true;
    _noResultsFound = false;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.fetchCurrentWeather(cityName);
      _noResultsFound = false;
    } catch (e) {
      _currentWeather = null;
      _noResultsFound = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
