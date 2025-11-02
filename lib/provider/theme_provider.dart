import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  void changeTheme(ThemeMode newThemeMode) {
    if (themeMode != newThemeMode) {
      themeMode = newThemeMode;
    }
    notifyListeners();
  }
}
