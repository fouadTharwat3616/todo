import 'package:flutter/material.dart';
class AppTheme{
  static Color primaruColor=Color(0xff5D9CEC);
  static Color bk_color_light=Color(0xffDFECDB);
  static Color bk_color_dark=Color(0xff060E1E);
  static Color greencolor=Color(0xff61E757);
  static Color redcolor=Color(0xffEC4B4B);
  static Color blackcolor=Color(0xff141922);
  static Color greycolor=Color(0xffC8C9CB);
  static Color whitecolor=Colors.white;

  static ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaruColor,
    ),
      scaffoldBackgroundColor: bk_color_light,

  );
  static ThemeData DarkTheme=ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaruColor,
    ),
    scaffoldBackgroundColor: bk_color_dark,

  );
}