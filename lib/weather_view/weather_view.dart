import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/weather_controller/weather_service.dart';
import 'package:weatherapp/weather_model/weather_info.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  TextEditingController citycontroller = TextEditingController();
  String defaulttext = "Enter your city..";
  String inputcity = "";
  var temps = " °C";
  final _weatherServices = WeatherService("55f33875d41e4e1fff2190140ed2f55b");
  WeatherInfo? _weather;

  fetchWeather() async {
    try {
      final weather = await _weatherServices.getWeather(inputcity);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }

    if (inputcity.isNotEmpty) {
      setState(() {
        temps = "${_weather?.temp.toDouble()} °C";
      });
    }
  }

  String getWeatherAnime(String? weatherDesc) {
    if (weatherDesc == null) return "assets/default.json";

    switch (weatherDesc.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/cloudy.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return "assets/rain.json";
      case 'thunderstorm':
        return "assets/thunder.json";
      case 'clear':
        return "assets/sunny.json";

      default:
        return "assets/sunny.json";
    }
  }

  String getWeatherSlogan(String? weatherDesc) {
    if (weatherDesc == null) return " ";

    switch (weatherDesc.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "Gloomy but cozy";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return "Let the rain wash away all your worries";
      case 'thunderstorm':
        return "Stay home..";
      case 'clear':
        return "Chillin’ in the heat";

      default:
        return " ";
    }
  }

  @override
  void dispose() {
    super.dispose();
    citycontroller.text;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 5, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      width: 30,
                      child: TextField(
                        controller: citycontroller,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Enter a city',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            inputcity = citycontroller.text.toUpperCase();
                            fetchWeather();

                            citycontroller.clear();
                          });
                        },
                        icon: const Icon(Icons.location_on)),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.center,
                  child: SelectableText(
                    inputcity,
                    style: const TextStyle(
                        fontSize: 33, fontWeight: FontWeight.w400),
                  )),
              const SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    temps,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  )),
              const SizedBox(
                height: 15,
              ),
              Text(
                _weather?.weatherDesc ?? "",
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              Expanded(
                  child: Lottie.asset(getWeatherAnime(_weather?.weatherDesc))),
              Text(getWeatherSlogan(_weather?.weatherDesc),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dancingScript(
                    textStyle: const TextStyle(fontSize: 35),
                  )),
              const SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
