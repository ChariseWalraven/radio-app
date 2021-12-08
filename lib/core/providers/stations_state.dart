import 'package:flutter/material.dart';
import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:radio_app/model/station_stream/station_stream_filter.dart';
import 'package:radio_app/services/location_service.dart';
import 'package:radio_app/services/stream_service.dart';

//This is the state manager class for the stations lists on the home page
class StationsState extends ChangeNotifier {
  int offset = 0;
  static const int limit = 10;
  LocationService locationService = LocationService();

  //We can create getters against any lower level service directly
  //There is no need to keep a copy of the streamlist here

  // general stations list
  StreamService stationsService = StreamService();
  List<StationStream> _stations = [];

  List<StationStream> get stations => _stations;

  int get stationsCount => _stations.length;
  bool get isLoading => stationsService.isLoading;

  StationStreamFilter _filter = StationStreamFilter(limit: 10);

  set filter(StationStreamFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  StationsState() {
    init();
  }

  @override
  void dispose() {
    debugPrint('RadioPlayerState.dispose');
    super.dispose();
  }

  void init() async {
    _stations = await stationsService.getStreams(_filter);
    notifyListeners();
  }

  void updateStreamList() async {
    StationStreamFilter filter =
        StationStreamFilter(limit: 10, offset: 0);
    await StreamService().getStreams(filter, isUpdate: true);
    notifyListeners();
  }

  void updateStreamListWithFilter(StationStreamFilter filter) async {
    await StreamService().getStreams(filter, isUpdate: true);
    notifyListeners();
  }
}
