import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

//weather service to handle weather api
class WeatherService {
  final String apiKey = "47d7bc01ca164a6699d15514243105";
  // final String currentBaseUrl = "http://api.weatherapi.com/v1/current.json";
  final String forecastBaseUrl = "http://api.weatherapi.com/v1/forecast.json";
  final String historyBaseUrl = "http://api.weatherapi.com/v1/history.json";

  Future<Weather> fetchCurrentWeather(String cityName) async {
    final url =
        '${forecastBaseUrl.trim()}?key=${apiKey.trim()}&q=${cityName.trim()}&days=1&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Weather>> fetch7dayForecast(String cityName) async {
    final encodedCityName = Uri.encodeComponent(cityName.trim());
    final url =
        '${forecastBaseUrl.trim()}?key=${apiKey.trim()}&q=$encodedCityName&days=7&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final forecastDays = data['forecast']['forecastday'] as List;

      List<Weather> forecast = forecastDays
          .map((day) => Weather.fromForecastJson(day, cityName))
          .toList();

      return forecast;
    } else {
      throw Exception(
          'Failed to load 7-day forecast data: ${response.statusCode}');
    }
  }

  Future<List<Weather>> getHistoricalWeather(String cityName) async {
    final encodedCityName = Uri.encodeComponent(cityName.trim());
    List<Weather> historicalWeather = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i + 1));
      String dateString = date.toIso8601String().split('T').first;
      final url =
          '${historyBaseUrl.trim()}?key=${apiKey.trim()}&q=$encodedCityName&dt=$dateString';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final dayData = data['forecast']['forecastday'][0];
        historicalWeather.add(Weather.fromForecastJson(dayData, cityName));
      } else {
        throw Exception(
            'Failed to load historical weather data for $dateString: ${response.statusCode}');
      }
    }

    return historicalWeather;
  }
}
