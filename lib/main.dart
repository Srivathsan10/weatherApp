import 'package:flutter/material.dart';
import 'package:weatherapp/weather_view/weather_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyWeather",
      home: const WeatherView(),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 206, 219, 225)),
    );
  }
}
