import 'package:flutter/cupertino.dart';
import 'package:lingo_jam/services/stations_collection_service.dart';

class FavouritesState extends ChangeNotifier {
  final StationsCollectionService _stationsCollectionService = StationsCollectionService(title: "Favourite Stations", isFavouritesList: true);


  StationsCollectionService get stationsCollectionService => _stationsCollectionService;

  bool get isLoading => _stationsCollectionService.isLoading; 

  FavouritesState() {
    _init();
  }

  _init() async {
    await refreshFavourites();
  }

  Future<void> refreshFavourites() async {
    await _stationsCollectionService.refreshStations();
    notifyListeners();
  }

}