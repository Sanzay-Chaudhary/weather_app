//represent the structure of the weather data
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

//factory constructor for current data
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'].toDouble(),
      description: json['current']['condition']['text'],
      iconUrl: "http:${json['current']['condition']['icon']}",
      maxTemp:
          json['forecast']['forecastday'][0]['day']['maxtemp_c'].toDouble(),
      minTemp:
          json['forecast']['forecastday'][0]['day']['maxtemp_c'].toDouble(),
      sunrise: json['forecast']['forecastday'][0]['astro']['sunrise'],
      sunset: json['forecast']['forecastday'][0]['astro']['sunset'],
      humidity: json['current']['humidity'],
      windSpeed: json['current']['wind_kph'].toDouble(),
      date: DateTime.now(),
    );
  }
//factory constructor for forecast data
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
