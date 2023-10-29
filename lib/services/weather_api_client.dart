import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather> getCurrentWeather(String? location) async {
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=7512f949abe76aad2898171b2437cb50&units=metric");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Weather.fromJSON(body);
  }
}

