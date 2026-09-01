import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  '29°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Mostly Sunny',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Dhaka, Bangladesh',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const Text(
            '☀️',
            style: TextStyle(fontSize: 58),
          ),
        ],
      ),
    );
  }
}