import 'package:radio_app/core/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/local_stations_state.dart';
import 'package:radio_app/core/providers/stations_state.dart';

import 'radio_app.dart';

void main() async {
  runApp(
    //instantiate the RadioPlayerState class which holds the state for the entire time the app is running
    //Everything in this state class is now universally available wherever you have context.
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
