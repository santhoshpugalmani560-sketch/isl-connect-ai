import 'package:flutter/material.dart';

import '../../widgets/bottom_nav.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNav(),
      ),
    );
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 24,
            ),
            child: Column(
              children: [

                const SizedBox(height: 20),

                Image.asset(
                 "assets/images/logo.png",
                 width: 160,
                 height: 160,
                 fit: BoxFit.contain,
                ),

                const SizedBox(height: 24),

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Login to continue your ISL journey",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 40),
                                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.cyan,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1A254B),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.cyan,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1A254B),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BCD4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white24,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white24,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: OutlinedButton.icon(
                    onPressed: () {
                    
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.white24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: const Color(0xFF1A254B),
                    ),
                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 34,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Continue with Google",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}