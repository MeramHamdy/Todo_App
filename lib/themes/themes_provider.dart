import 'package:app1/themes/theme.dart';
import 'package:flutter/material.dart';

class ThemesProvider with ChangeNotifier{
  bool isDarkMode = false;
  ThemeData get currentTheme => isDarkMode? darkMode : lightMode;

  void toggleThem(){
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}