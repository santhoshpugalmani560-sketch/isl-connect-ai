import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../widgets/feature_card.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/stat_card.dart';

import '../translate/translate_screen.dart';
import '../translate/camera_sign_screen.dart';
import '../learn/learn_screen.dart';
import '../relay/relay_screen.dart';
import '../history/history_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // HEADER
              // =========================================================

              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.waving_hand_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "ISL CONNECT AI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoryScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // =========================================================
              // SEARCH BAR
              // =========================================================

              Container(
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "Search translation, AI, lessons...",
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // HERO CARD
              // =========================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF243B72),
                      Color(0xFF0C6E8C),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "INDIAN SIGN LANGUAGE",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Break Every\nCommunication\nBarrier",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "AI powered communication for hospitals,\n"
                      "schools, banks and public services.",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.5,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 220,
                      child: GradientButton(
                        text: "Start Translating",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TranslateScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =========================================================
              // QUICK FEATURES
              // =========================================================

              const Text(
                "Quick Features",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1.0,
                children: [
                  // CAMERA
                  FeatureCard(
                    icon: Icons.camera_alt,
                    title: "Camera",
                    subtitle: "Translate",
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CameraSignScreen(),
                        ),
                      );
                    },
                  ),

                  // VOICE
                  FeatureCard(
                    icon: Icons.mic,
                    title: "Voice",
                    subtitle: "Speech → Sign",
                    color: Colors.cyan,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TranslateScreen(),
                        ),
                      );
                    },
                  ),

                  // LEARN
                  FeatureCard(
                    icon: Icons.menu_book,
                    title: "Learn",
                    subtitle: "ISL Lessons",
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LearnScreen(),
                        ),
                      );
                    },
                  ),

                  // RELAY
                  FeatureCard(
                    icon: Icons.video_call,
                    title: "Relay",
                    subtitle: "Live Support",
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RelayScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // =========================================================
              // STATISTICS
              // =========================================================

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    StatCard(
                      number: "98%",
                      title: "Accuracy",
                      color: Colors.green,
                    ),
                    StatCard(
                      number: "120+",
                      title: "Signs",
                      color: Colors.cyan,
                    ),
                    StatCard(
                      number: "24/7",
                      title: "AI",
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =========================================================
              // RECENT HISTORY
              // =========================================================

              const Text(
                "Recent History",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // SPEECH → SIGN
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor:
                            Colors.blue.withValues(alpha: .2),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.cyan,
                        ),
                      ),
                      title: const Text(
                        "Speech → Sign",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "Today • 10:30 AM",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white54,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoryScreen(),
                          ),
                        );
                      },
                    ),

                    const Divider(color: Colors.white24),

                    // CAMERA DETECTION
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor:
                            Colors.orange.withValues(alpha: .2),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.orange,
                        ),
                      ),
                      title: const Text(
                        "Camera Detection",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "Yesterday",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white54,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoryScreen(),
                          ),
                        );
                      },
                    ),

                    const Divider(color: Colors.white24),

                    // TEXT → SIGN
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor:
                            Colors.green.withValues(alpha: .2),
                        child: const Icon(
                          Icons.text_fields,
                          color: Colors.green,
                        ),
                      ),
                      title: const Text(
                        "Text → Sign",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "2 days ago",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white54,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoryScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =========================================================
              // FOOTER
              // =========================================================

              const Center(
                child: Text(
                  "ISL CONNECT AI\n"
                  "Breaking Communication Barriers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
