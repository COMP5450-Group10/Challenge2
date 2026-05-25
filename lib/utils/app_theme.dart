import 'package:flutter/material.dart';

class AppTheme {
  static const Color cream = Color(0xFFF7F1E8);
  static const Color warmBrown = Color(0xFF8B5E3C);
  static const Color darkBrown = Color(0xFF3D2B1F);
  static const Color sage = Color(0xFF8FA58E);
  static const Color softBeige = Color(0xFFE7D8C9);
  static const Color charcoal = Color(0xFF2E2E2E);
  static const Color luxuryGold = Color(0xFFC4A35A);

  static ThemeData themeForMood(String mood) {
    Color seedColor;

    switch (mood) {
      case 'Luxury':
        seedColor = luxuryGold;
        break;
      case 'Natural':
        seedColor = sage;
        break;
      case 'Productive':
        seedColor = const Color(0xFF6A8CAF);
        break;
      case 'Relaxing':
        seedColor = const Color(0xFF9CAFAA);
        break;
      case 'Cozy':
        seedColor = warmBrown;
        break;
      default:
        seedColor = warmBrown;
    }

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        primary: seedColor,
        secondary: sage,
        background: cream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        foregroundColor: darkBrown,
        elevation: 0,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: seedColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}