import 'package:advanced_widgets/themes/material_theme.dart';
import 'package:flutter/material.dart';

enum CustomThemeColor { light, dark, red, green, blue }

CustomThemeColor nextEnum(CustomThemeColor value) {
  final nextIndex = (value.index + 1) % CustomThemeColor.values.length;
  return CustomThemeColor.values[nextIndex];
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = themeLight;
  CustomThemeColor _customThemeColor = CustomThemeColor.light;

  ThemeData get current => _currentTheme;
  CustomThemeColor get themeColor => _customThemeColor;

  toggle(CustomThemeColor themeColor) {
    switch (themeColor) {
      case CustomThemeColor.light: {
        _customThemeColor = CustomThemeColor.light;
        _currentTheme = themeLight;
        break;
      }
      case CustomThemeColor.dark: {
        _customThemeColor = CustomThemeColor.dark;
        _currentTheme = themeDark;
        break;
      }
      case CustomThemeColor.red: {
        _customThemeColor = CustomThemeColor.red;
        _currentTheme = themeRed;
        break;
      }
      case CustomThemeColor.green: {
        _customThemeColor = CustomThemeColor.green;
        _currentTheme = themeGreen;
        break;
      }
      case CustomThemeColor.blue: {
        _customThemeColor = CustomThemeColor.blue;
        _currentTheme = themeBlue;
        break;
      }
    }
    notifyListeners();
  }
}
