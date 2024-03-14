import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
class settingsProvider with ChangeNotifier{
  ThemeMode themeMode=ThemeMode.light;
  String languagecode='en';
  Color get bodyColor =>
      themeMode==ThemeMode.light? AppTheme.bk_color_light: AppTheme.bk_color_dark;
  Color get backGround_bottom_sheet_settings_container =>
      themeMode==ThemeMode.light? AppTheme.whitecolor: AppTheme.blackcolor;
  Color get HintText =>
      themeMode==ThemeMode.light? AppTheme.blackcolor: AppTheme.whitecolor;
  void changeTheme(ThemeMode selectedTheme)
  {
    if (selectedTheme == themeMode) {
      return;
    }
    themeMode=selectedTheme;
    notifyListeners();
  }
  void changeLanguage(String selectedLanguage)
  {
    if (selectedLanguage == languagecode) {
      return;
    }
    languagecode=selectedLanguage;
    notifyListeners();
  }

}

