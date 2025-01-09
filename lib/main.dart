import 'package:flutter/material.dart';
import 'package:weather_app/weather_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      // home: const WeatherApp(),
      home: WeatherApp(
        onToggleTheme: toggleTheme,
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       ;
      //     },
      //     child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      //   ),
    );
  }
}
