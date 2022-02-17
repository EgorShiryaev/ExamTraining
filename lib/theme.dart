import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamTrainingTheme {
  static const Color lightThemeTextColor = Colors.black;

  static TextTheme lightThemeTextTheme = TextTheme(
    headline1: GoogleFonts.roboto(
      fontSize: 24.0,
      color: lightThemeTextColor,
    ),
    subtitle1: GoogleFonts.roboto(
      fontSize: 18.0,
      color: lightThemeTextColor,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 16.0,
      color: lightThemeTextColor,
    ),
  );

  static const Color borderColor = Colors.black;

  static const Color lightThemeBgColor = Colors.white;

  static const Color bgColor = Color(0xFFF5F5F5);

  static const Color lightThemeIconColor = Colors.black;

  static const Color selectedIconThemeColor = Colors.green;
  static const Color unselectedIconThemeColor = Colors.black;

  static const Color cardColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: lightThemeBgColor,
      titleTextStyle: lightThemeTextTheme.headline1,
    ),
    scaffoldBackgroundColor: bgColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightThemeBgColor,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 32),
    ),
    iconTheme: const IconThemeData(color: lightThemeIconColor, size: 32),
    textTheme: lightThemeTextTheme,
    cardTheme: const CardTheme(color: cardColor),
  );
}
