import 'package:flutter/material.dart';

class AppColors {
  static const orange = Color(0xFFF26522);
  static const grey = Color(0xFFEAEAEA);
  static const red = Color(0xFFD20B0B);
  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF57AEDE);
}

class AppTypography {
  static const String fontFamily = 'IBM Plex Sans';
  static TextStyle heading = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle body = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
  );
}
