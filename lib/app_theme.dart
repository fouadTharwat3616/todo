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
    primaryColor: primaruColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaruColor,
      titleTextStyle: TextStyle(
        color: whitecolor,
        fontSize: 22,
        fontWeight: FontWeight.bold
      )
    ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: blackcolor
          ),
        bodyMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaruColor
        ),
          bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: blackcolor
          )
      ),
      scaffoldBackgroundColor: bk_color_light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: primaruColor,
      unselectedItemColor: greycolor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaruColor,
      foregroundColor: whitecolor,
      shape: CircleBorder(side: BorderSide(color: whitecolor,width: 2))
    )

  );
  static ThemeData DarkTheme=ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaruColor,
    ),
    scaffoldBackgroundColor: bk_color_dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaruColor,
        unselectedItemColor: greycolor,
      )

  );
}