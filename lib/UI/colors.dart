import 'package:flutter/material.dart';

class AppColors {
  static const orange = Color(0xFFF26522);
  static const darkOrange = Color.fromARGB(255, 255, 81, 0);
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
  static TextStyle body18 = const TextStyle(
      fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle medium = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
}
