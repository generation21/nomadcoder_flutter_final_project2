import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String fontFamily = 'Roboto';

  // Headline Styles
  static TextStyle get headline1 => const TextStyle(
    fontSize: 96,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.5,
  );

  static TextStyle get headline2 => const TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  );

  static TextStyle get headline3 =>
      const TextStyle(fontSize: 48, fontWeight: FontWeight.w400);

  static TextStyle get headline4 => const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  // Title Styles
  static TextStyle get title1 => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static TextStyle get title2 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  // Body Styles
  static TextStyle get bodyText1 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyText2 => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle get bodyText3 => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Colors.grey.shade600,
    letterSpacing: 0.4,
  );

  // Button Style
  static TextStyle get button => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  // Caption Style
  static TextStyle get caption => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: Colors.grey.shade600,
  );
}
