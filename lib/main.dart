import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NAYAN.',
      theme: ThemeData(
        primaryColor: const Color(0xFFffc500),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFffc500),
          secondary: const Color(0xFF03DAC6),
          surface: const Color(0xFF1E1E1E),
          background: const Color(0xFF0A0A0A),
        ),
      ),
      home: const PortfolioHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}