import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lingo_jam/core/providers/stations_state.dart';
import 'package:lingo_jam/services/stations_collection_service.dart'
    as services_sc;
import 'package:lingo_jam/ui.dart';

class StationsCollections extends StatelessWidget {
  const StationsCollections({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Consumer<StationsState>(
      builder: (_, StationsState state, Widget? child) {
        // show a spinner if the state is loading
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // otherwise show the list of stations collections
        return ListView.builder(
          itemCount: state.stations.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, int i) {
            services_sc.StationsCollectionService stationsCollectionService =
                state.stations[i];
            return StationsCollection(
              collectionIndex: i,
              stationsCollectionService: stationsCollectionService,
            );
          },
        );
      },
    );
  }
}
