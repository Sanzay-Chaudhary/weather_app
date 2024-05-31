import 'dart:convert';
import 'package:http/http.dart' as http;

// class to handle weather api
class WeatherService {
  final String apiKey = "47d7bc01ca164a6699d15514243105";
  final String forecastBaseUrl = " http://api.weatherapi.com/v1/forecast.json";
  final String searchBaseUrl = "http://api.weatherapi.com/v1/search.json";

// method to retrieve current weather
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    //final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=1&aqi=no&alerts=no';
    final url =
        '${forecastBaseUrl.trim()}?key=${apiKey.trim()}&q=${city.trim()}&days=1&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

//method to retrieve the 7day weather data
  Future<Map<String, dynamic>> fetch7dayforecast(String city) async {
    final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=1&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

//method to fetch city suggestion
  Future<Map<String, dynamic>> fetchCitySuggestions(String query) async {
    final url = '$searchBaseUrl?key=$apiKey&q=$query';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search cities');
    }
  }
}
