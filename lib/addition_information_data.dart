import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInformation({
    super.key,
    required this.icon,
    required this.label,
    required this.value,    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 110,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                value,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
