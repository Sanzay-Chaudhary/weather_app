//This model classes will represent the weather data
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

//This constructor initializes all the properties of the class using the values passed to it.
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
  });

// extracts the relevant fields from the JSON and assigns them to the corresponding properties of the Weather class.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'],
      description: json['current']['condition']['text'],
      iconUrl: "http:${json['current']['condition']['icon']}",
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      sunrise: json['forecast']['forecastday'][0]['astro']['sunrise'],
      sunset: json['forecast']['forecastday'][0]['astro']['sunset'],
      humidity: json['current']['humidity'],
      windSpeed: json['current']['wind_kph'],
    );
  }
}
