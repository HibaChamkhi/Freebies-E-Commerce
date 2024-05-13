import 'package:flutter/material.dart';

abstract class AppTheme {
  static const String fontFamily = 'DMSans';

  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: fontFamily,
      primaryColor: Colors.black,
      splashColor: Colors.transparent,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      splashColor: Colors.transparent,
      fontFamily: fontFamily,
    );
  }
}


const alabaster = Color(0xFFFAFAFA);
const marinerApprox = Color(0xFF3669C9);
// const bgGrey = Color(0xFFFAFAFA);
const boxGrey = Color(0xFFEDEDED);
