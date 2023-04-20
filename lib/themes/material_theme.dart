import 'package:flutter/material.dart';

ThemeData _themeLight = ThemeData.light();
ThemeData _themeDark = ThemeData.dark();

ThemeData themeLight = _themeLight.copyWith(
  appBarTheme: const AppBarTheme(
    color: Colors.amber,
  ),
  primaryColor: Colors.black,
  floatingActionButtonTheme:
      _floatingActionButtonThemeData(_themeLight.floatingActionButtonTheme),
  textTheme: _textThemeLight(_themeLight.textTheme),
);

ThemeData themeDark = _themeDark.copyWith(
  appBarTheme: const AppBarTheme(
    color: Colors.blueGrey,
  ),
  primaryColor: Colors.blue,
  textTheme: _textThemeDark(_themeDark.textTheme),
);

ThemeData themeRed = _themeDark.copyWith(
  appBarTheme: const AppBarTheme(
    color: Colors.indigo,
  ),
  textTheme: _textThemeDark(_themeDark.textTheme),
);

ThemeData themeGreen = _themeDark.copyWith(
  appBarTheme: const AppBarTheme(
    color: Colors.deepPurple,
  ),
  primaryColor: Colors.yellow,
  textTheme: _textThemeDark(_themeDark.textTheme),
);

ThemeData themeBlue = _themeLight.copyWith(
  appBarTheme: const AppBarTheme(
    color: Colors.pinkAccent,
  ),
  textTheme: _textThemeDark(_themeDark.textTheme),
);

TextTheme _textThemeLight(TextTheme base) {
  return base.copyWith(
    bodySmall: base.bodySmall?.copyWith(
      color: Colors.blue,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      color: Colors.yellow,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      color: Colors.red,
      decorationColor: Colors.black,
    ),
  );
}

TextTheme _textThemeDark(TextTheme base) {
  return base.copyWith(
    bodySmall: base.bodySmall?.copyWith(
      color: Colors.teal,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      color: Colors.cyan,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      color: Colors.black,
      decorationColor: Colors.green,
    ),
  );
}

FloatingActionButtonThemeData _floatingActionButtonThemeData(
    FloatingActionButtonThemeData base) {
  return base.copyWith(
    backgroundColor: Colors.yellow,
  );
}
