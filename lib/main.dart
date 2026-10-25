import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'theme/app_colors.dart'; // Pastikan ini di-import

void main() {
  runApp(const MercedesApp());
}

class MercedesApp extends StatelessWidget {
  const MercedesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercedes-Benz Showroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Kita pakai tema Light Mode (Putih)
        primaryColor: AppColors.moonstone,
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.moonstone,
          brightness: Brightness.light, // Ubah jadi light
          surface: AppColors.surfaceGrey,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundWhite,
          foregroundColor: AppColors.gunmetal,
          elevation: 0,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
