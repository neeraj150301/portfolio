import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF111111); // Void Black
  static const Color surface = Color(0x1AFFFFFF); // Glassy White (10% opacity)
  static const Color surfaceLight = Color(0x2AFFFFFF); // Lighter Glass

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFEEEEEE);
  static const Color textDim = Color(0xFFAAAAAA);

  // Accents (Google Colors)
  static const Color accentBlue = Color(0xFF4285F4);
  static const Color accentRed = Color(0xFFEA4335);
  static const Color accentYellow = Color(0xFFFBBC05);
  static const Color accentGreen = Color(0xFF34A853);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accentBlue, accentRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
