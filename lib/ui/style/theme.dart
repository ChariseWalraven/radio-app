import 'package:flutter/material.dart';

ColorScheme appColorScheme =
    ColorScheme.fromSwatch(primarySwatch: Colors.green, accentColor: Colors.yellow).copyWith(
      onBackground: Colors.black,
      background: Colors.grey.shade300,
      tertiary: Colors.cyan.shade600,
      surface: Colors.white,
      onSurface: Colors.grey.shade900,
      inverseSurface: Colors.grey.shade900,
      onInverseSurface: Colors.white,
    );

ThemeData theme = ThemeData(
  colorScheme: appColorScheme,
  scaffoldBackgroundColor: appColorScheme.background,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white.withOpacity(0), // set background to be transparent so corner radius is preserved
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white.withOpacity(0), // set background to be transparent so corner radius is preserved
    unselectedItemColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    size: 24.0,
  ),
);
