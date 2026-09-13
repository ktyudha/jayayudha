import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/app_color.dart';

abstract class AppTheme {
  static const String fontFamily = 'NunitoSans';

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,

      colorScheme: const ColorScheme.light(
        primary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
        tertiary: AppColor.tertiaryColor,
        surface: AppColor.surfaceColor,
        error: AppColor.errorColor,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColor.primaryColor,
        elevation: 2,
        shadowColor: Colors.black26,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryColor,
        ),
      ),

      bottomAppBarTheme: const BottomAppBarThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.white,
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColor.primaryColor.withValues(alpha: 0.5);
            }
            return AppColor.primaryColor;
          }),
          textStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            return Colors.white;
          }),
          side: WidgetStateBorderSide.resolveWith((states) {
            return const BorderSide(color: AppColor.primaryColor);
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ),

      tabBarTheme: TabBarThemeData(
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColor.primaryColor, width: 2.6),
        ),
        dividerHeight: 0,
      ),
    );
  }
}
