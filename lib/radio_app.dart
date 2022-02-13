import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/services/favourites_service.dart';
import 'package:radio_app/ui/home_screen.dart';
import 'package:flutter/material.dart';


class RadioApp extends StatelessWidget {
  const RadioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavouritesService favoritesService = FavouritesService();
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
