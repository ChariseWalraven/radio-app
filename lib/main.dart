import 'package:radio_app/core/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/favourites_state.dart';
import 'package:radio_app/core/providers/stations_state.dart';

import 'radio_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
        ),
        ChangeNotifierProvider<StationsState>(
          create: (_) => StationsState(),
        ),
        ChangeNotifierProvider<FavouritesState>(
          create: (_) => FavouritesState(),
        ),
      ],
      child: const RadioApp(),
    ),
  );
}
