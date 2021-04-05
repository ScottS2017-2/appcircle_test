import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    final textTheme = _getTextTheme(brightness: Brightness.light);

    return ThemeData(
      backgroundColor: AppColors.backgroundWhite,
    scaffoldBackgroundColor: AppColors.backgroundWhite,
      primaryColor: AppColors.xanaduBlue,
      accentColor: AppColors.darkSienna,
      buttonColor: AppColors.brownSugar,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      dividerTheme: _dividerTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static const _dividerTheme = DividerThemeData(
    indent: 16,
    space: 0,
  );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: AppColors.xanaduBlue,
      onPrimary: AppColors.backgroundWhite,
    ),
  );

  static TextTheme _getTextTheme({required Brightness brightness}) {
    final themeData = ThemeData(brightness: brightness);

    return GoogleFonts.exo2TextTheme(themeData.textTheme).copyWith(
      headline1: GoogleFonts.orbitron(),
      headline2: GoogleFonts.orbitron(),
      headline3: GoogleFonts.orbitron(),
      headline4: GoogleFonts.orbitron(),
    );
  }
}
