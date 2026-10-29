import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: .15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}