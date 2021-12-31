import 'package:flutter/material.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/model/station/stations_filter.dart';
import 'package:radio_app/services/location_service.dart';
import 'package:radio_app/services/stations_service.dart';

//This is the state manager class for the stations lists on the home page
class StationsState extends ChangeNotifier {
  int offset = 0;
  static const int limit = 10;
  LocationService locationService = LocationService();

  //We can create getters against any lower level service directly
  //There is no need to keep a copy of the streamlist here

  // general stations list
  StationsService stationsService = StationsService();
  List<Station> _stations = [];

  List<Station> get stations => _stations;

  int get stationsCount => _stations.length;
  bool get isLoading => stationsService.isLoading;

  StationsFilter _filter = StationsFilter(limit: 10);

  set filter(StationsFilter filter) => _filter = filter;

  StationsState() {
    init();
  }

  @override
  void dispose() {
    debugPrint('RadioPlayerState.dispose');
    super.dispose();
  }

  void init() async {
    // _stations = await stationsService.getStreams(_filter);
    // notifyListeners();
  }

  void updateStreamList() async {
    StationsFilter filter = StationsFilter(limit: 10, offset: 0);
    await StationsService().getStreams(filter, isUpdate: true);
    notifyListeners();
  }

  void updateStreamListWithFilter(StationsFilter filter) async {
    await StationsService().getStreams(filter, isUpdate: true);
    notifyListeners();
  }

  Future<int> setInitialStations(StationsFilter filter,
      {bool notify = false}) async {
    _stations = await StationsService().getStreams(filter);
    if (notify) notifyListeners();
    return _stations.length;
  }
}
