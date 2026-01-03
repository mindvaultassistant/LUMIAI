import 'package:flutter/material.dart';

class UltraTheme {
  static const Color neonCyan = Color(0xFF4CD7FF);
  static const Color neonViolet = Color(0xFF7C4DFF);
  static const Color neonPink = Color(0xFFFF4D9D);
  static const Color bgTop = Color(0xFF050A16);
  static const Color bgMid = Color(0xFF0A1440);
  static const Color bgBot = Color(0xFF02040A);

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final cs = ColorScheme.fromSeed(
      seedColor: neonCyan,
      brightness: Brightness.dark,
    );

    return base.copyWith(
      colorScheme: cs.copyWith(
        primary: neonCyan,
        secondary: neonViolet,
        tertiary: neonPink,
        surface: const Color(0xFF0B1022),
        background: bgTop,
      ),
      scaffoldBackgroundColor: bgTop,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: base.textTheme.copyWith(
        headlineSmall: const TextStyle(fontWeight: FontWeight.w900),
        titleLarge: const TextStyle(fontWeight: FontWeight.w900),
        titleMedium: const TextStyle(fontWeight: FontWeight.w800),
        bodyLarge: const TextStyle(height: 1.25),
        bodyMedium: const TextStyle(height: 1.25),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.06),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonCyan,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: neonViolet,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: neonCyan, width: 1.4),
        ),
      ),
    );
  }
}
