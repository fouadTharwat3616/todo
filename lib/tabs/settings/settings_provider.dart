import 'package:flutter/material.dart';
class settingsProvider with ChangeNotifier{
  ThemeMode themeMode=ThemeMode.light;
  String languagecode='en';

  void changeTheme(ThemeMode selectedTheme)
  {
    themeMode=selectedTheme;
    notifyListeners();
  }
  void changeLanguage(String selectedLanguage)
  {
    languagecode=selectedLanguage;
    notifyListeners();
  }

}

