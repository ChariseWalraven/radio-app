import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lingo_jam/core/providers/favourites_state.dart';
import 'package:lingo_jam/core/providers/stations_state.dart';

import '../lingo_jam.dart';

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
      child: const LingoJam(),
    ),
  );
}
