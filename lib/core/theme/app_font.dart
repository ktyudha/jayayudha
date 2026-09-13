import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppFont {
  static const String primary = 'NunitoSans';

  // .sp = scale proportional ke screen + text scale user
  static double get xs => 10.sp;
  static double get sm => 12.sp;
  static double get md => 14.sp;
  static double get base => 16.sp;
  static double get lg => 18.sp;
  static double get xl => 20.sp;
  static double get xl2 => 24.sp;
  static double get xl3 => 30.sp;
  static double get xl4 => 36.sp;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const double leadingTight = 1.2;
  static const double leadingNormal = 1.5;
  static const double leadingRelax = 1.75;
}
