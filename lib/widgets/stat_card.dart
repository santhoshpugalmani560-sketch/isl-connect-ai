import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String number;
  final String title;
  final Color color;

  const StatCard({
    super.key,
    required this.number,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              color: color,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}