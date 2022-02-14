import 'package:flutter/cupertino.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/services/favourites_service.dart';
import 'package:radio_app/services/stations_collection_service.dart';

class FavouritesState extends ChangeNotifier {
  final FavouritesService _favouritesService = FavouritesService();
  final StationsCollectionService _stationsCollectionService = StationsCollectionService(title: "Favourite Stations", isFavouritesList: true);
  
  List<Station> _favourites = [];
  List<Station> get favourites => _favourites;

  FavouritesState() {
    _init();
  }

  _init() async {
    debugPrint('FavouritesState::_init');
    _favourites = await _stationsCollectionService.refreshStations();
    notifyListeners();
  }

  // TODO: method for add favourite, remove favourite
  addFavourite(String favourite) async {
    await _favouritesService.addFavourite(favourite);
    refreshFavourites();
  }

  removeFavourite(String favourite) async {
    _favourites = await _stationsCollectionService.refreshStations();
    refreshFavourites();
  }

  Future<void> refreshFavourites({bool shouldNotifyListeners = true}) async {
    _favourites = await _stationsCollectionService.refreshStations();
    if(!shouldNotifyListeners) return;
    notifyListeners();
  }

}