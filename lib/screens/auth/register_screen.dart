import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 2, 109),
      appBar: AppBar(
        title: const Text("Create Account"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Image.asset(
                "assets/images/logo.png",
                height: 120,
              ),

              const SizedBox(height: 25),

              const Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Join ISL CONNECT AI",
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 31, 218),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 35),

              TextField(
                controller: nameController,
                decoration: inputDecoration(
                  hint: "Full Name",
                  icon: Icons.person,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: inputDecoration(
                  hint: "Email Address",
                  icon: Icons.email,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: inputDecoration(
                  hint: "Password",
                  icon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: confirmPasswordController,
                obscureText: hideConfirmPassword,
                decoration: inputDecoration(
                  hint: "Confirm Password",
                  icon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hideConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Registration logic will be added later.
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}