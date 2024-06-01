import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

//provider class  manage the state of the weather data.
class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? _currentWeather;
  bool _loading = false;
  bool _noResultsFound = false;

//getter methods
  Weather? get currentWeather => _currentWeather;
  bool get loading => _loading;
  bool get noResultsFound => _noResultsFound;

//asynchronous method to fetch weather data for a given city name.
  Future<void> fetchWeather(String cityName) async {
    _loading = true; //to indicate that data loading has started.
    _noResultsFound = false; //before new data fetching
    notifyListeners();

    try {
      _currentWeather = await _weatherService.fetchCurrentWeather(cityName);
      _noResultsFound = false; //if data is successfully fetched.
    } catch (e) {
      _currentWeather = null;
      _noResultsFound = true; //indicates no result found
    } finally {
      _loading = false; //indicate that data loading has finished.
      notifyListeners();
    }
  }
}
