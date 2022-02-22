import 'package:flutter/material.dart';
import 'package:lingo_jam/ui/screens/favourites_screen.dart';
import 'package:lingo_jam/ui/screens/home_screen.dart';
import 'package:lingo_jam/ui/screens/test_screen.dart';

class RoutingService {
  static const String home = '/';
  static const String favourites = '/favourites';
  static const String test = '/test';

  static const Widget homeScreen = HomeScreen();
  static const Widget favouritesScreen = FavouritesScreen();
  static const Widget testScreen = TestScreen();

  static const List<String> _namedRoutes = [home, favourites, test];

  static final Map<String, WidgetBuilder> routes = {
    RoutingService.favourites: (BuildContext context) =>
        RoutingService.favouritesScreen,
    RoutingService.home: (BuildContext context) => RoutingService.homeScreen,
    RoutingService.test: (BuildContext context) => RoutingService.testScreen,
  };

  static Route createRoute(int index) {
    Widget screen = homeScreen;
    if (index == 1) screen = favouritesScreen;
    if (index == 2) screen = testScreen;

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  static int indexByRouteName(String name) {
    return _namedRoutes.indexOf(name);
  }

  static void routeToIndex(BuildContext context, int index) {
    final newNamedRoute = _namedRoutes[index];
    bool isNewRouteSameAsCurrent = false;

    Navigator.of(context).popUntil((route) {
      if (route.settings.name == newNamedRoute) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    if (!isNewRouteSameAsCurrent) {
      Navigator.pushNamed(context, newNamedRoute);
    }
  }
}
