import 'package:flutter/material.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/ui/station/stations_collections.dart';
import 'package:provider/provider.dart';
// ignore: implementation_imports

class StationsView extends StatefulWidget {
  const StationsView({Key? key}) : super(key: key);

  @override
  State<StationsView> createState() => _StationsViewState();
}

class _StationsViewState extends State<StationsView> {
  @override
  Widget build(BuildContext context) {
    bool isNotPaused =
        context.watch<AppState>().playingState != PlayingState.none;
    final double playerHeight = (MediaQuery.of(context).size.height * 0.15) + 5;
    return Padding(
      padding: EdgeInsets.only(bottom: isNotPaused ? playerHeight : 0),
      child: const StationsCollections(),
    );
  }
}
