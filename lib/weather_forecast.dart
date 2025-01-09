import 'package:flutter/material.dart';

class WeatherForecastClass extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;
  const WeatherForecastClass({
    super.key,
    required this.time,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      // padding: EdgeInsets.all(10.0),
      width: 110,
      height: 130,
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10),
            Icon(
              icon,
              size: 35,
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
