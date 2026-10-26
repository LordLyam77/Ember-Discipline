import 'package:flutter/material.dart';

class EmberColors {
  // Backgrounds & Surfaces
  static const Color background = Color(0xFF0B0B0C);
  static const Color card = Color(0xFF151517);
  static const Color cardElevated = Color(0xFF1C1C1F);
  static const Color border = Color(0xFF26262A);

  // Brand Oranges (used sparingly for streaks, primaries, progress, glows)
  static const Color primaryOrange = Color(0xFFFF6A00);
  static const Color brightOrange = Color(0xFFFF8A1F);
  static const Color softGlow = Color(0xFFFFB066);

  // Typography
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF8A8A90);
  static const Color textTertiary = Color(0xFF5E5E65);

  // Status & Utility
  static const Color slipWarning = Color(0xFFE5484D);
  static const Color success = Color(0xFF3DDC84);
  static const Color infoBlue = Color(0xFF3A86FF);
}

class EmberTheme {
  static const double cardRadius = 20.0;
  static const double buttonRadius = 14.0;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: EmberColors.background,
      primaryColor: EmberColors.primaryOrange,
      colorScheme: const ColorScheme.dark(
        primary: EmberColors.primaryOrange,
        secondary: EmberColors.brightOrange,
        surface: EmberColors.card,
        error: EmberColors.slipWarning,
        onPrimary: Colors.white,
        onSurface: EmberColors.textPrimary,
        onError: Colors.white,
      ),
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        // Sora for headings and prominent numbers
        displayLarge: TextStyle(
          fontFamily: 'Sora',
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: EmberColors.textPrimary,
          letterSpacing: -1.5,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Sora',
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: EmberColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Sora',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: EmberColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Sora',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: EmberColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Sora',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: EmberColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Sora',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: EmberColors.textPrimary,
        ),
        // Inter for body and labels
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: EmberColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: EmberColors.textPrimary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: EmberColors.textSecondary,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: EmberColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: EmberColors.textPrimary,
        ),
      ),
      cardTheme: const CardThemeData(
        color: EmberColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
          side: BorderSide(color: EmberColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: EmberColors.textPrimary),
        titleTextStyle: TextStyle(
          fontFamily: 'Sora',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: EmberColors.textPrimary,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: EmberColors.card,
        selectedItemColor: EmberColors.primaryOrange,
        unselectedItemColor: EmberColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
