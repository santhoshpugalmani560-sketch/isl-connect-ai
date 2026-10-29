import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  bool isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 300,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 40),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 17,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08111F),

      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == 2;
          });
        },
        children: [
          buildPage(
            image: "assets/images/intro1.png",
            title: "Welcome to ISL CONNECT AI",
            description:
                "AI-powered communication platform that bridges the gap between speech and Indian Sign Language.",
          ),
          buildPage(
            image: "assets/images/intro2.png",
            title: "Speech to Sign",
            description:
                "Convert spoken words into Indian Sign Language instantly with intelligent AI translation.",
          ),
          buildPage(
            image: "assets/images/intro3.png",
            title: "Sign to Speech",
            description:
                "Translate sign language into speech and readable text for seamless communication.",
          ),
        ],
      ),

      bottomSheet: Container(
        height: 110,
        color: const Color(0xFF08111F),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),

        child: isLastPage
            ? SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    foregroundColor: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color(0xFF00BCD4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 10,
                      dotColor: Colors.white24,
                      activeDotColor: Color(0xFF00BCD4),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Color(0xFF00BCD4),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}