import 'package:flutter/material.dart';
import 'package:hospital_management/initialize_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 3,
        ),
        delay);
    super.initState();
  }

  void delay() {
    InitializeApp.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9458D),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/logo_white.png",
              height: 250,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
