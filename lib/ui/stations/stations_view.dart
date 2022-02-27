import 'package:flutter/material.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/ui.dart';
import 'package:provider/provider.dart';
// ignore: implementation_imports

class StationsView extends StatelessWidget {
  const StationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // player is always visible if playingState is anything other than none
    bool playerVisible =
        context.watch<AppState>().playingState != PlayingState.none;
    final double playerHeight = getPlayerHeight(context) + kPlayerHeightMargin;

    return Padding(
      padding: EdgeInsets.only(bottom: playerVisible ? playerHeight : 0),
      child: const StationsCollections(),
    );
  }
}

/// screens
/// -- views
/// --- widgets (common use widgets, specific widgets)
/// 
/// View Model Controller
/// View - UI
/// Model - Data Structure
/// Controller - Logic
/// 
/// ui/stations/
///   -- stations_screen.dart (currently home_screen.dart)
///   -- stations_view.dart
///   -- stations_*.dart
///   /favourites/
///   -- favourites_screen.dart
///   -- favourites_view.dart
///   -- favourites_*.dart
///   /widgets/
///   -- bottom_bar.dart
///   -- // whatever reusable widgets
/// 
/// try WillPopScope to implement custom backbutton functionality
/// move some of the scaffold code into a custom scaffold to be reused
