import 'package:flutter/material.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/ui/station/stations_collections.dart';
import 'package:lingo_jam/ui/style/style_constants.dart';
import 'package:lingo_jam/ui/style/style_utils.dart';
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
