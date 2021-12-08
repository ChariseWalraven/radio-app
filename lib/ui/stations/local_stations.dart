import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/local_stations_state.dart';
import 'package:radio_app/ui/stations/stations_list.dart';

class LocalStations extends StatelessWidget {
  const LocalStations({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalStationsState>(
      builder: (context, localStationsState, _) => Column(
        children: <Widget>[
          const Text(
                  "Local Stations",
                  textScaleFactor: 1.75,
                ),
                SizedBox(
                  height: 180.0,
                  child: StationList(stations: localStationsState.stations),
                ),
        ],
      ),
    );
  }
}