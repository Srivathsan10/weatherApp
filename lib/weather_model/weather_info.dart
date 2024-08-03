class WeatherInfo {
  late final String cityname;
  late final double temp;
  late final String weatherDesc;

  WeatherInfo(
      {required this.cityname, required this.temp, required this.weatherDesc});

  factory WeatherInfo.fromJson(Map<String, dynamic> data) {
    return WeatherInfo(
        cityname: data["name"],
        temp: data['main']['temp'].toDouble(),
        weatherDesc: data['weather'][0]['main']);
  }
}
