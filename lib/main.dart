import 'package:radio_app/core/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/local_stations_state.dart';
import 'package:radio_app/core/providers/stations_state.dart';
// import 'package:radio_app/services/favourites_service.dart';

import 'radio_app.dart';

void main() {
  // FavouritesService favoritesService = FavouritesService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
        ChangeNotifierProvider<StationsState>(
          create: (context) => StationsState(),
        ),
        ChangeNotifierProvider<LocalStationsState>(
          create: (_) => LocalStationsState(),
        ),
      ],
      child: const RadioApp(),
    ),
  );
}
