import 'package:flutter/material.dart';

import '../core/app_colors.dart';

import '../screens/home/home_screen.dart';
import '../screens/translate/translate_screen.dart';
import '../screens/learn/learn_screen.dart';
import '../screens/assistant/ai_assistant_screen.dart';
import '../screens/profile/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    TranslateScreen(),
    LearnScreen(),
    AIAssistantScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(
        height: 78,
        backgroundColor: AppColors.card,
        indicatorColor: AppColors.primary.withValues(alpha: .20),
        selectedIndex: currentIndex,

        labelBehavior:
            NavigationDestinationLabelBehavior.alwaysShow,

        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.translate_outlined),
            selectedIcon: Icon(Icons.translate),
            label: "Translate",
          ),

          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: "Learn",
          ),

          NavigationDestination(
            icon: Icon(Icons.smart_toy_outlined),
            selectedIcon: Icon(Icons.smart_toy),
            label: "AI",
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}