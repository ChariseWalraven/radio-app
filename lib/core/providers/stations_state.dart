import 'package:flutter/material.dart';
import 'package:lingo_jam/services/stations_collection_service.dart';
import 'package:lingo_jam/services/stations_collections_service.dart';

//This is the state manager class for the stations lists on the home page
class StationsState extends ChangeNotifier {
  int offset = 0;
  static const int limit = 10;

  bool isUpdating = false;
  bool isLoading = false;

  // station collections
  static List<StationsCollectionService> _collections = StationsCollectionsService.collections;

  List<StationsCollectionService> get stations => _collections;
  // bool get isLoading => stationsService.isLoading;

  StationsState() {
    _init();
  }

  void _init() async {
    isLoading = true;
    notifyListeners();
    _collections = await StationsCollectionsService.populateCollections();
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateStreamList(int stationIndex) async {
    if(!isUpdating) {
      isUpdating = true;
      notifyListeners();
      List<StationsCollectionService> collections = StationsCollectionsService.collections;
      StationsCollectionService stationCollectionService = collections[stationIndex];
      StationsCollectionsService.collections;
      await stationCollectionService.refreshStations(isUpdate: true);
      notifyListeners();
      isUpdating = false;
      return;
    }
  }
}
