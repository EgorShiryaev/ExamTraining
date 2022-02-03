import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamTrainingTheme {
  static Color lightThemeTextColor = Colors.black;
  // static Color darkThemeTextColor = Colors.white;

  static TextTheme lightThemeTextTheme = TextTheme(
    headline1: GoogleFonts.roboto(
      fontSize: 24.0,
      color: lightThemeTextColor,
    ),
    subtitle1: GoogleFonts.roboto(
      fontSize: 18.0,
      color: lightThemeTextColor,
    ),
  );

  static Color lightThemeBgColor = Colors.white;
  // static Color darkThemeBgColor = Colors.black;

  static const Color bgColor = Color(0xFFF5F5F5);

  static Color lightThemeIconColor = Colors.black;

  static Color selectedIconThemeColor = Colors.green;
  static Color unselectedIconThemeColor = Colors.black;

  static Color cardColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: lightThemeBgColor,
      titleTextStyle: lightThemeTextTheme.headline1,
    ),
    scaffoldBackgroundColor: bgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightThemeBgColor,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      selectedIconTheme: const IconThemeData(size: 32),
      unselectedIconTheme: const IconThemeData(size: 32),
    ),
    iconTheme: IconThemeData(color: lightThemeIconColor, size: 32),
    textTheme: lightThemeTextTheme,
    cardTheme: CardTheme(color: cardColor),
  );

  // static ThemeData light() {
  //   return ThemeData(
  //     brightness: Brightness.light,
  //     checkboxTheme: CheckboxThemeData(
  //       fillColor: MaterialStateColor.resolveWith(
  //         (states) {
  //           return Colors.black;
  //         },
  //       ),
  //     ),
  //     cardTheme: CardTheme(color: Colors.white),
  //     appBarTheme: const AppBarTheme(
  //       foregroundColor: Colors.black,
  //       backgroundColor: Colors.white,
  //     ),
  //     backgroundColor: bodyBackgroundColor,
  //     floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //       foregroundColor: Colors.white,
  //       backgroundColor: Colors.black,
  //     ),
  //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //       selectedItemColor: Colors.green,
  //       unselectedItemColor: Colors.black,
  //     ),
  //     textTheme: lightTextTheme,
  //   );
  // }

}
