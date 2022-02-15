import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/ui/screens/favourites_screen.dart';
import 'package:radio_app/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/ui/screens/test_screen.dart';
import 'package:radio_app/ui/style/theme.dart';

class RadioApp extends StatelessWidget {
  const RadioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TestScreen(),
      routes: <String, WidgetBuilder>{
        kFavouritesRouteName: (BuildContext context) => const FavouritesScreen(),
        "/test": (BuildContext context) => const TestScreen(),
      },
      title: kAppName,
      theme: ThemeData(
        colorScheme: appColorScheme,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.0),
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
