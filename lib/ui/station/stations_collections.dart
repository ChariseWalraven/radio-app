import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/stations_state.dart';
import 'package:radio_app/ui/station/stations_collection.dart';

class StationsCollections extends StatelessWidget {
  const StationsCollections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StationsState>(
      builder: (BuildContext context, StationsState state, Widget? child) {
        debugPrint('state: ${state.stations.length}');
        // return const Text('Placeholder');
        return ListView.builder(
          itemCount: state.stations.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int i) {
            return StationsCollection(
                title: state.stations[i].title,
                stations: state.stations[i].collection);
          },
        );
      },
    );
  }
}