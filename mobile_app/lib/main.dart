import 'package:flutter/material.dart';
import 'screens/app_colors.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const PhytoscanApp());
}

class PhytoscanApp extends StatelessWidget {
  const PhytoscanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phytoscan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryGreen,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}