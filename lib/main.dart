import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ISLConnectAI());
}

class ISLConnectAI extends StatelessWidget {
  const ISLConnectAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISL CONNECT AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}