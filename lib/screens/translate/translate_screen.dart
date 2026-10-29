import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import 'speech_to_sign_screen.dart';
import 'text_to_sign_screen.dart';
import 'camera_sign_screen.dart';
import 'sign_to_text_screen.dart';
import 'sign_to_speech_screen.dart';

class TranslateScreen extends StatelessWidget {
  const TranslateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Translate",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2D3F8F),
                    Color(0xFF1785A6),
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "AI Translation",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Choose a Translation Mode",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            TranslationCard(
              icon: Icons.mic,
              color: Colors.blue,
              title: "Speech to Sign",
              subtitle: "Convert speech into Indian Sign Language",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SpeechToSignScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 18),

            TranslationCard(
              icon: Icons.keyboard,
              color: Colors.green,
              title: "Text to Sign",
              subtitle: "Convert text into Indian Sign Language",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TextToSignScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 18),

            TranslationCard(
              icon: Icons.camera_alt,
              color: Colors.orange,
              title: "Camera Sign Detection",
              subtitle: "Recognize sign language using camera",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CameraSignScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 18),

            TranslationCard(
              icon: Icons.text_fields,
              color: Colors.teal,
              title: "Sign to Text",
              subtitle: "Convert sign language into text",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignToTextScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 18),

            TranslationCard(
              icon: Icons.record_voice_over,
              color: Colors.purple,
              title: "Sign to Speech",
              subtitle: "Convert sign language into speech",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignToSpeechScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TranslationCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const TranslationCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: .15),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Colors.white70,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}