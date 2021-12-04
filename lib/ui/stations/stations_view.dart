import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/core/providers/stations_state.dart';
import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/ui/player/player_bar.dart';
import 'package:radio_app/ui/stations/stations_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StationsView extends StatelessWidget {
  StationsView({Key? key}) : super(key: key);

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();


  /// The alignment to be used next time the user scrolls or jumps to an item.
  static double alignment = 0;


  @override
  Widget build(BuildContext context) {
    return Consumer<StationsListState>(
      builder: (context, _state, child) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Local Stations",
                textScaleFactor: 1.75,
              ),
              SizedBox(
                height: 180.0,
                child: StationList(stations: _state.localStations),
              ),
              const Text(
                "Stations in English",
                textScaleFactor: 1.75,
              ),
              SizedBox(
                height: 180.0,
                child: StationList(stations: _state.langStations),
              ),
            ],
          ),
        );
      }
    );
  }
}