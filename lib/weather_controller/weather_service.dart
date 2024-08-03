import 'dart:convert';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/weather_model/weather_info.dart';

class WeatherService {
  static const baseurl = "https://api.openweathermap.org/data/2.5/weather";

  final String apikey;

  WeatherService(this.apikey);

  Future<WeatherInfo> getWeather(String cityname) async {
    final response = await http
        .get(Uri.parse('$baseurl?q=$cityname&appid=$apikey&units=metric'));

    if (response.statusCode == 200) {
      return WeatherInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to Load");
    }
  }

  // Future getCurrentcity() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   List placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);

  //   String? city = placemarks[0].locality;

  //   return city ?? '';
  // }
}
