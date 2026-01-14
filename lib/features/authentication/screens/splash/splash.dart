import 'package:demopetnest/features/authentication/screens/login/login.dart';
import 'package:demopetnest/features/authentication/screens/signup/signup.dart';
import 'package:demopetnest/features/authentication/screens/splash/widget/button.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 96,
              width: 96,
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.pets, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              "PetNest",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Your Pet's Happy Place",
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            PrimaryButton(
              text: "Sign In",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: "Sign Up",
              outlined: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
