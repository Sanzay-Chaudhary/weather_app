import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/weather_provider.dart';
import 'package:weather_app/views/home_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        home: HomeScreen(),
      ),
    );
  }
}
