import 'package:flutter/material.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/model/station/stations_filter.dart';
import 'package:radio_app/services/location_service.dart';
import 'package:radio_app/services/stations_collection_service.dart';
import 'package:radio_app/services/stations_collections_service.dart';
import 'package:radio_app/services/stations_service.dart';

//This is the state manager class for the stations lists on the home page
class StationsState extends ChangeNotifier {
  int offset = 0;
  static const int limit = 10;
  LocationService locationService = LocationService();

  // station collections
  static List<StationsCollectionService> _collections = StationsCollectionsService.collections;

  // general stations list
  StationsService stationsService = StationsService();
  List<Station> _stations = [];

  List<StationsCollectionService> get stations => _collections;

  int get stationsCount => _stations.length;
  // bool get isLoading => stationsService.isLoading;

  StationsState() {
    _init();
  }

  @override
  void dispose() {
    debugPrint('RadioPlayerState.dispose');
    super.dispose();
  }

  void _init() async {
    // _stations = await stationsService.getStreams(_filter);
    // notifyListeners();
    debugPrint('initializing stations state');
    _collections = await StationsCollectionsService.populateCollections();
    debugPrint("populated ${_collections.length} collections.");
    // debugPrint('checking station favourites working');
    // debugPrint('This should be true: ${_collections[1].collection[0].isFavourite}. \nThis should be false: ${_collections[0].collection[0].isFavourite}');
    notifyListeners();
  }

  void updateStreamList() async {
    StationsFilter filter = const StationsFilter(limit: 10, offset: 0);
    await StationsService.getStreams(filter, isUpdate: true);
    notifyListeners();
  }

  void updateStreamListWithFilter(StationsFilter filter) async {
    await StationsService.getStreams(filter, isUpdate: true);
    notifyListeners();
  }

  Future<int> setInitialStations(StationsFilter filter,
      {bool notify = false}) async {
    _stations = await StationsService.getStreams(filter);
    if (notify) notifyListeners();
    return _stations.length;
  }
}
