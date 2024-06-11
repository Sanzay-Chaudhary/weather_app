class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String iconUrl;
  final double maxTemp;
  final double minTemp;
  final String sunrise;
  final String sunset;
  final int humidity;
  final double windSpeed;
  final DateTime date;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconUrl,
    required this.maxTemp,
    required this.minTemp,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.windSpeed,
    required this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location'] != null && json['location']['name'] != null
          ? json['location']['name']
          : '',
      temperature: json['current'] != null && json['current']['temp_c'] != null
          ? json['current']['temp_c'].toDouble()
          : 0.0,
      description: json['current'] != null &&
              json['current']['condition'] != null &&
              json['current']['condition']['text'] != null
          ? json['current']['condition']['text']
          : '',
      iconUrl: json['current'] != null &&
              json['current']['condition'] != null &&
              json['current']['condition']['icon'] != null
          ? "http:${json['current']['condition']['icon']}"
          : '',
      maxTemp: json['forecast'] != null &&
              json['forecast']['forecastday'] != null &&
              json['forecast']['forecastday'][0]['day'] != null &&
              json['forecast']['forecastday'][0]['day']['maxtemp_c'] != null
          ? json['forecast']['forecastday'][0]['day']['maxtemp_c'].toDouble()
          : 0.0,
      minTemp: json['forecast'] != null &&
              json['forecast']['forecastday'] != null &&
              json['forecast']['forecastday'][0]['day'] != null &&
              json['forecast']['forecastday'][0]['day']['mintemp_c'] != null
          ? json['forecast']['forecastday'][0]['day']['mintemp_c'].toDouble()
          : 0.0,
      sunrise: json['forecast'] != null &&
              json['forecast']['forecastday'] != null &&
              json['forecast']['forecastday'][0]['astro'] != null &&
              json['forecast']['forecastday'][0]['astro']['sunrise'] != null
          ? json['forecast']['forecastday'][0]['astro']['sunrise']
          : '',
      sunset: json['forecast'] != null &&
              json['forecast']['forecastday'] != null &&
              json['forecast']['forecastday'][0]['astro'] != null &&
              json['forecast']['forecastday'][0]['astro']['sunset'] != null
          ? json['forecast']['forecastday'][0]['astro']['sunset']
          : '',
      humidity: json['current'] != null && json['current']['humidity'] != null
          ? json['current']['humidity']
          : 0,
      windSpeed: json['current'] != null && json['current']['wind_kph'] != null
          ? json['current']['wind_kph'].toDouble()
          : 0.0,
      date: DateTime.now(),
    );
  }

  factory Weather.fromForecastJson(Map<String, dynamic> json, String cityName) {
    return Weather(
      cityName: cityName, // Pass the city name here
      temperature: (json['day']?['avgtemp_c'] ?? 0.0).toDouble(),
      description: json['day']?['condition']?['text'] ?? '',
      iconUrl: "http:${json['day']?['condition']?['icon'] ?? ''}",
      maxTemp: (json['day']?['maxtemp_c'] ?? 0.0).toDouble(),
      minTemp: (json['day']?['mintemp_c'] ?? 0.0).toDouble(),
      sunrise: json['astro']?['sunrise'] ?? '',
      sunset: json['astro']?['sunset'] ?? '',
      humidity: 0, // Average humidity not provided in forecast JSON structure
      windSpeed:
          0.0, // Average wind speed not provided in forecast JSON structure
      date: DateTime.parse(json['date']),
    );
  }
}
