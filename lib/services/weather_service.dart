import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

// class to handle weather api
class WeatherService {
  final String apiKey = "47d7bc01ca164a6699d15514243105";
  final String forecastBaseUrl = " http://api.weatherapi.com/v1/forecast.json";

  // method to retrieve current weather
  Future<Weather> fetchCurrentWeather(String cityName) async {
    final url =
        '${forecastBaseUrl.trim()}?key=${apiKey.trim()}&q=${cityName.trim()}&days=1&aqi=no&alerts=no'; //complete URL

    //sends an HTTP GET request to the constructed URL and waits for the response.
    final response = await http.get(Uri.parse(url));

    //handling the response
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response
          .body); //parses the JSON response body into a Dart Map object.

      //converts the parsed JSON data into a Weather object using the Weather.fromJson constructor.
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
