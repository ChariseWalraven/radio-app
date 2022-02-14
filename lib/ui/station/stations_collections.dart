import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/stations_state.dart';
import 'package:radio_app/ui/station/stations_collection.dart';
import 'package:radio_app/services/stations_collection_service.dart'
    as services_sc;

class StationsCollections extends StatelessWidget {
  const StationsCollections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StationsState>(
      builder: (BuildContext context, StationsState state, Widget? child) {
        debugPrint('state: ${state.stations.length}');
        return ListView.builder(
          itemCount: state.stations.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int i) {
            services_sc.StationsCollectionService currentStation = state.stations[i];
            return StationsCollection(
              title: currentStation.title,
              stations: currentStation.collection,
            );
          },
        );
      },
    );
  }
}
