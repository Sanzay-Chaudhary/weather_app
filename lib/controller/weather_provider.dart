import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

//weather provider for storing weather data
class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? _currentWeather;
  bool _loading = false;
  bool _noResultsFound = false;
  List<Weather>? _forecastWeather;
  List<Weather>? _historicalWeather;

  Weather? get currentWeather => _currentWeather;
  bool get loading => _loading;
  bool get noResultsFound => _noResultsFound;
  List<Weather>? get forecastWeather => _forecastWeather;
  List<Weather>? get historicalWeather => _historicalWeather;

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

  Future<void> fetch7dayWeather(String cityName) async {
    _loading = true;
    _noResultsFound = false;
    notifyListeners();

    try {
      _forecastWeather = await _weatherService.fetch7dayForecast(cityName);
      _noResultsFound = _forecastWeather == null || _forecastWeather!.isEmpty;
    } catch (e) {
      print('Error fetching 7-day weather: $e');
      _forecastWeather = null;
      _noResultsFound = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> previous7dayWeather(String cityName) async {
    _loading = true;
    _noResultsFound = false;
    notifyListeners();

    try {
      _historicalWeather = await _weatherService.getHistoricalWeather(cityName);
      _noResultsFound =
          _historicalWeather == null || _historicalWeather!.isEmpty;
    } catch (e) {
      print('Error fetching previous 7-day weather: $e');
      _historicalWeather = null;
      _noResultsFound = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
