import 'package:flutter/material.dart';
import 'home_page.dart';
import '../theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  void _login() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Email dan password wajib diisi'),
            backgroundColor: Colors.red),
      );
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Foto
          Positioned.fill(
            child: Image.asset(
              'assets/images/car_s500.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.surfaceGrey),
            ),
          ),

          // 2. Overlay Putih Transparan
          Positioned.fill(
            child: Container(
              color:
                  Colors.white.withValues(alpha: 0.85), // Bikin foto agak pudar
            ),
          ),

          // 3. Konten Login
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_mercedes.png',
                      height: 90,
                      errorBuilder: (_, __, ___) => const Icon(
                          Icons.directions_car,
                          size: 90,
                          color: AppColors.gunmetal),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'BenzDrive',
                      style: TextStyle(
                          color: AppColors.gunmetal,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    const Text(
                      'Showroom & Luxury Experience',
                      style: TextStyle(
                          color: AppColors.moonstone,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                    const SizedBox(height: 50),

                    // Input Email
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: AppColors.gunmetal),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: AppColors.textGrey),
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: AppColors.gunmetal),
                        filled: true,
                        fillColor: Colors.white, // Kotak Putih bersih
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.moonstone),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input Password
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      style: const TextStyle(color: AppColors.gunmetal),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: AppColors.textGrey),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: AppColors.gunmetal),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textGrey),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.moonstone),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Tombol Login (Gunakan Moonstone)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.moonstone,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 5,
                        ),
                        onPressed: _login,
                        child: const Text('MASUK',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
