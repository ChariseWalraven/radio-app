import 'package:flutter/material.dart';

ColorScheme appColorScheme =
    ColorScheme.fromSwatch(primarySwatch: Colors.green, accentColor: Colors.yellow).copyWith(
      onBackground: Colors.grey.shade900,
      background: Colors.white,
      tertiary: Colors.cyan.shade300
    );

ThemeData theme = ThemeData(
  colorScheme: appColorScheme,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white.withOpacity(0),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white.withOpacity(0.0),
    unselectedItemColor: Colors.black,
  ),
  iconTheme: const IconThemeData(
    size: 24.0,
  ),
);
