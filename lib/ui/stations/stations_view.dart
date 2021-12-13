import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:radio_app/core/abstract_classes/order.dart';
import 'package:radio_app/core/providers/local_stations_state.dart';
import 'package:radio_app/model/station_stream/station_stream_filter.dart';
import 'package:radio_app/services/location_service.dart';
import 'package:radio_app/ui/stations/local_stations.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StationsView extends StatefulWidget {
  const StationsView({Key? key}) : super(key: key);


  @override
  State<StationsView> createState() => _StationsViewState();
}

class _StationsViewState extends State<StationsView> {
  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();
  final LocationService _locationService = LocationService();
  String? _countryCode;

  Future<String?> getCountryCode() async {
    await _locationService.getLocation();
    _countryCode = await _locationService.getCountryCode();
    debugPrint('countryCode: $_countryCode');
    return _countryCode;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder<String?>(
            future: getCountryCode(),
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data != null) {
                StationStreamFilter filter = StationStreamFilter(
                  countrycode: snapshot.data ?? "GB",
                  limit: 10, 
                  order: Order.clickCount, 
                  reverse: true
                );

                context.read<LocalStationsState>().setInitialStations(filter, notify: true);
                return const LocalStations();
              } else {
                return const CircularProgressIndicator();
              }
            }
          ) ,
          const SizedBox(
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