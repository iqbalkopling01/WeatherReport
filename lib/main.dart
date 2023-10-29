import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weather_api_client.dart';
import 'package:weather/views/additional_info.dart';
import 'package:weather/views/current_weather.dart';
import 'city_selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  WeatherApiClient client = WeatherApiClient();
  Weather data = Weather();
  String location = "Depok";

  Future<void> getData() async {
    data = await client.getCurrentWeather(location);
  }

  Future<void> chooseCity(String city) async {
    setState(() {
      location = city;
    });
    await getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x000fff99),
      appBar: AppBar(
        backgroundColor: const Color(0x000fff99),
        elevation: 0.0,
        title: Text(
          "Weather Report",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            final selectedCity = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CitySelectionPage()),
            );
            if (selectedCity != null) {
              chooseCity(selectedCity);
            }
          },
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currentWeather(Icons.wb_sunny_sharp, "${data.temp}", location), // Menampilkan location
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Additional Info",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xdd212121),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                additionalinfo(
                  "${data.wind}",
                  "${data.humidity}",
                  "${data.pressure}",
                  "${data.feelsLike}",
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
