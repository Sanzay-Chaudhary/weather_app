import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/weather_provider.dart';

class PreviousForecastScreen extends StatefulWidget {
  final String cityName;
  const PreviousForecastScreen({super.key, required this.cityName});

  @override
  // ignore: library_private_types_in_public_api
  _PreviousForecastScreenState createState() => _PreviousForecastScreenState();
}

class _PreviousForecastScreenState extends State<PreviousForecastScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      weatherProvider.previous7dayWeather(widget.cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous 7 Day Forecast for ${widget.cityName}'),
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
          } else if (weatherProvider.historicalWeather != null) {
            return ListView.builder(
              itemCount: weatherProvider.historicalWeather!.length,
              itemBuilder: (context, index) {
                final previousForecastData =
                    weatherProvider.historicalWeather![index];
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
                      previousForecastData.iconUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${previousForecastData.date.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Temperature: ${previousForecastData.temperature}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Max Temp: ${previousForecastData.maxTemp}°C',
                          textAlign: TextAlign.right,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Min Temp: ${previousForecastData.minTemp}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Description: ${previousForecastData.description}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Sunrise: ${previousForecastData.sunrise}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Sunset: ${previousForecastData.sunset}',
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
