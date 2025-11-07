import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  // getters ;

  bool get isDark => _isDark;

  // Method to toggle between white and dark mode

  void toggleTheme(){
    _isDark = !_isDark;
    notifyListeners();
  }

  ThemeData get currentTheme{
    return _isDark ? ThemeData.dark() : ThemeData.light();
  }
}