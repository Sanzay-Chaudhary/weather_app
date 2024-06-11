import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/weather_provider.dart';

class ForecastScreen extends StatefulWidget {
  final String cityName;
  const ForecastScreen({super.key, required this.cityName});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      weatherProvider.fetch7dayWeather(widget.cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7 Day Forecast for ${widget.cityName}'),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, _) {
          if (weatherProvider.loading) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A2344),
                    Color.fromARGB(255, 125, 32, 142),
                    Colors.purple,
                    Color.fromARGB(255, 151, 44, 170),
                  ],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          } else if (weatherProvider.noResultsFound) {
            return const Center(child: Text('No results found.'));
          } else if (weatherProvider.forecastWeather != null) {
            return ListView.builder(
              itemCount: weatherProvider.forecastWeather!.length,
              itemBuilder: (context, index) {
                final forecastData = weatherProvider.forecastWeather![index];
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1A2344),
                        Color.fromARGB(255, 125, 32, 142),
                        Colors.purple,
                        Color.fromARGB(255, 151, 44, 170),
                      ],
                    ),
                  ),
                  child: ListTile(
                    leading: Image.network(
                      forecastData.iconUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${forecastData.date.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Temperature: ${forecastData.temperature}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Max Temp: ${forecastData.maxTemp}°C',
                          textAlign: TextAlign.right,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Min Temp: ${forecastData.minTemp}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Description: ${forecastData.description}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Sunrise: ${forecastData.sunrise}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Sunset: ${forecastData.sunset}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}
