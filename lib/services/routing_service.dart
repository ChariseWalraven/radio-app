import 'package:flutter/material.dart';
import 'package:radio_app/ui/screens/favourites_screen.dart';
import 'package:radio_app/ui/screens/home_screen.dart';
import 'package:radio_app/ui/screens/test_screen.dart';
// import 'package:radio_app/ui/screens/home_screen.dart';

class RoutingService {
  static const String home = '/';
  static const String favourites = '/favourites';
  static const String test = '/test';

  static const Widget homeScreen = HomeScreen();
  static const Widget favouritesScreen = FavouritesScreen();
  static const Widget testScreen = TestScreen();


  static Route createRoute(int index) {
    Widget screen = homeScreen;
    if(index == 1) screen = favouritesScreen;
    if(index == 2) screen = testScreen;

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}