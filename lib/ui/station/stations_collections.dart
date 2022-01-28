import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/stations_state.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/ui/station/stations_collection.dart';

class StationsCollections extends StatelessWidget {
  StationsCollections({Key? key}) : super(key: key);

  // final StationCollection _stationCollection = StationCollection(  
  //   title: "Test stations", 
  //   filter: StationsFilter(limit: 10, hidebroken: true,)
  // );

  // final _models.StationsCollection _stationsCollection = _models.StationsCollection();


  @override
  Widget build(BuildContext context) {
  var _state = Provider.of<StationsState>(context);

  // debugPrint(_state.offset.toString());
    return Column(
      children: const [
        Text('You were working on the future builder for the stations collection list...')
      ]
    );
  }
}


/*
_stationsCollection.stationCollectionList.map((stationCollection) => 
        FutureBuilder(
          future: stationCollection.stations,
          builder: (context, AsyncSnapshot<List<Station>> snapshot) {
            if(snapshot.hasData) {
              debugPrint('${snapshot.data!.length}');
              return StationsCollection(
              title: '${stationCollection.title}',
              stations: snapshot.data ?? [],
              );
            }
            else {
              return const CircularProgressIndicator();
            }
          }
        )
      ).toList()
*/