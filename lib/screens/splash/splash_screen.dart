import 'dart:async';
import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF08111F),
              Color(0xFF0B1736),
              Color(0xFF111C44),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  "assets/images/logo.png",
                  width: 190,
                  height: 190,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 30),

                // App Name
                const Text(
                  "ISL CONNECT AI",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                // Tagline
                const Text(
                  "Breaking Communication Barriers\nwith Artificial Intelligence",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 50),

                const SizedBox(
                  width: 34,
                  height: 34,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF00BCD4)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}