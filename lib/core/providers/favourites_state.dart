import 'package:flutter/cupertino.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/services/stations_collection_service.dart';

class FavouritesState extends ChangeNotifier {
  final StationsCollectionService _stationsCollectionService = StationsCollectionService(title: "Favourite Stations", isFavouritesList: true);
  
  List<Station> _favourites = [];
  List<Station> get favourites => _favourites;

  FavouritesState() {
    _init();
  }

  _init() async {
    _favourites = await _stationsCollectionService.refreshStations();
    notifyListeners();
  }

  Future<void> refreshFavourites({bool shouldNotifyListeners = true}) async {
    _favourites = await _stationsCollectionService.refreshStations();
    if(!shouldNotifyListeners) return;
    notifyListeners();
  }

}