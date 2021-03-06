import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.white,
      tertiary: Colors.white,
      onTertiary: Colors.black,
      shadow: Colors.grey,
      surface: Colors.black,
      error: Colors.red,
      background: Color(0xFFF5F5F5),
    ),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      foregroundColor: Colors.black,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 24,
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
      headline5: GoogleFonts.roboto(
        fontSize: 24,
        color: Colors.black,
      ),
      headline6: GoogleFonts.roboto(
        fontSize: 24.0,
        color: Colors.black,
      ),
      subtitle1: GoogleFonts.roboto(
        fontSize: 24.0,
      ),
      caption: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 16,
      ),
      bodyText1: GoogleFonts.roboto(
        color: Colors.grey.shade700,
        fontSize: 20,
      ),
      overline: GoogleFonts.roboto(
        fontSize: 18,
      ),
      bodyText2: GoogleFonts.roboto(
        color: Colors.grey,
        fontSize: 18,
      ),
      headline4: GoogleFonts.roboto(
        fontSize: 20,
        color: Colors.black,
      ),
    ),
    splashColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 24),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      hourMinuteColor: Colors.grey.shade400,
      dayPeriodColor: Colors.grey.shade400,
      dayPeriodBorderSide: BorderSide.none,
      entryModeIconColor: Colors.black,
      helpTextStyle: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 18,
      ),
    ),
  );
}
