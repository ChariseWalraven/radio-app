import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/services/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/ui/style/theme.dart';

class RadioApp extends StatelessWidget {
  const RadioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutingService.home,
      routes: <String, WidgetBuilder> {
        RoutingService.favourites: (BuildContext context) => RoutingService.favouritesScreen,
        RoutingService.home: (BuildContext context) => RoutingService.homeScreen,
        RoutingService.test: (BuildContext context) => RoutingService.testScreen,
      },
      title: kAppName,
      theme: ThemeData(
        colorScheme: appColorScheme,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white.withOpacity(0),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.0),
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
