import 'dart:convert';
// import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/addition_information_data.dart';
import 'package:weather_app/secret_file.dart';
import 'package:weather_app/weather_forecast.dart';

class WeatherApp extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const WeatherApp({super.key, required this.onToggleTheme});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<Map<String, dynamic>> weather;

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,india&APPID=$apiKey"));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'Unexpected Error Occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<Map<String, dynamic>> getCurrentWeather() async {
  //   try {
  //     final filePath = 'assets/weather_data.json';
  //     final res = await rootBundle.loadString(filePath);
  //     final data = jsonDecode(res);
  //     return data;
  //     // data['list'][0]['main']['temp'];
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

// Rain
  IconData iconType(String weather) {
    if (weather == 'Clouds') {
      return Icons.cloud;
    }
    if (weather == 'Rain') {
      return Icons.cloudy_snowing;
    }
    if (weather == 'Clear') {
      return Icons.sunny;
    }
    return Icons.abc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: widget.onToggleTheme,
              icon: Icon(Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode)),
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Unexpected Error Occurred'));
          }
          final data = snapshot.data!;
          final listData = data['list'][0];
          final currentTemp = listData['main']['temp'];
          final currentWeather = listData['weather'][0]['main'];
          final currentWindSpeed = listData['wind']['speed'];
          final currentPressure = listData['main']['pressure'];
          final currentHumidity = listData['main']['humidity'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp°K',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              SizedBox(height: 20),
                              Icon(
                                iconType(currentWeather),
                                size: 60,
                              ),
                              SizedBox(height: 20),
                              Text(
                                '$currentWeather',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Weather Forecast',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 6; i++)
                //         WeatherForecastClass(
                //           time: data['list'][i + 1]['dt'].toString(),
                //           icon: iconType(
                //               data['list'][i + 1]['weather'][0]['main']),
                //           value: data['list'][i + 1]['main']['temp'].toString(),
                //         ),

                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 39,
                      itemBuilder: (context, index) {
                        final listData = data['list'][index + 1];
                        final time = DateTime.parse(listData['dt_txt']);
                        return WeatherForecastClass(
                          time: DateFormat.Hm().format(time).toString(),
                          icon: iconType(listData['weather'][0]['main']),
                          value: listData['main']['temp'].toString(),
                        );
                      }),
                ),
                SizedBox(height: 20),
                Text(
                  'Additional Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInformation(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInformation(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInformation(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
