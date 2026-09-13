import 'package:flutter/material.dart';

abstract class AppColor {
  // ─── Brand (referencing Blue Light tokens) ────────────────
  static const Color primaryColor = blueLight600;
  static const Color secondaryColor = blueLight300;
  static const Color tertiaryColor = blueLight200;
  static const Color surfaceColor = blueLight25;
  static const Color softCreamColor = blueLight50;

  // ─── Semantic ─────────────────────────────────────────────
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color successColor = Color(0xFF5CBA4B);

  // ─── Blue Light ───────────────────────────────────────────
  static const Color blueLight25 = Color(0xFFF5FBFF);
  static const Color blueLight50 = Color(0xFFF0F9FF);
  static const Color blueLight100 = Color(0xFFE0F2FE);
  static const Color blueLight200 = Color(0xFFB9E6FE);
  static const Color blueLight300 = Color(0xFF7CD4FD);
  static const Color blueLight400 = Color(0xFF36BFFA);
  static const Color blueLight500 = Color(0xFF0BA5EC);
  static const Color blueLight600 = Color(0xFF0086C9);
  static const Color blueLight700 = Color(0xFF026AA2);
  static const Color blueLight800 = Color(0xFF065986);
  static const Color blueLight900 = Color(0xFF0B4A6F);
  static const Color blueLight950 = Color(0xFF062C41);
}
