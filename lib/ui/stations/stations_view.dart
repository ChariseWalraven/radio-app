import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:radio_app/core/abstract_classes/order.dart';
import 'package:radio_app/core/providers/local_stations_state.dart';
import 'package:radio_app/model/station_stream/station_stream_filter.dart';
import 'package:radio_app/ui/stations/local_stations.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StationsView extends StatefulWidget {
  const StationsView({Key? key}) : super(key: key);

  /// The alignment to be used next time the user scrolls or jumps to an item.
  static double alignment = 0;

  @override
  State<StationsView> createState() => _StationsViewState();
}

class _StationsViewState extends State<StationsView> {
  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    // TODO: use country code from phone instead
    // TODO: create a flow for obtaining permission to access country code
    
    StationStreamFilter filter = StationStreamFilter(
      countrycode: "GB", 
      limit: 10, 
      order: Order.clickCount, 
      reverse: true
    );
    context.read<LocalStationsState>().setInitialStations(filter, notify: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          LocalStations(),
          SizedBox(
            child: Text('Coming soon!!'),
          )
        ],
      ),
    );
  }
}

/*
// NOTE: I've decided to implement this later in favor of focussing on local stations for the moment
const Text(
                "Stations in English",
                textScaleFactor: 1.75,
              ),
              SizedBox(
                height: 180.0,
                child: StationList(stations: _state.langStations),
              ),
              
 */