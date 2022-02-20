import 'package:flutter/material.dart';
import 'package:radio_app/services/stations_collection_service.dart';
import 'package:radio_app/services/stations_collections_service.dart';

//This is the state manager class for the stations lists on the home page
class StationsState extends ChangeNotifier {
  int offset = 0;
  static const int limit = 10;

  bool isUpdating = false;

  // station collections
  static List<StationsCollectionService> _collections = StationsCollectionsService.collections;

  List<StationsCollectionService> get stations => _collections;
  // bool get isLoading => stationsService.isLoading;

  StationsState() {
    _init();
  }

  void _init() async {
    _collections = await StationsCollectionsService.populateCollections();
    notifyListeners();
  }

  Future<void> updateStreamList(int stationIndex) async {
    if(!isUpdating) {
      isUpdating = true;
      notifyListeners();
      StationsCollectionService stationCollectionService = _collections[stationIndex];
      await stationCollectionService.refreshStations(isUpdate: true);
      debugPrint('Got ${stationCollectionService.collection.length} stations');
      notifyListeners();
      isUpdating = false;
      return;
    }
    debugPrint('Already updating. Not going to fetch more stations.');
  }
}
