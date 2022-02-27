// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/ui.dart';
import 'package:provider/provider.dart';

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
