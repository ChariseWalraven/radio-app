import 'package:flutter/cupertino.dart';
import 'package:radio_app/services/favourites_service.dart';

class FavouritesState extends ChangeNotifier {
  final FavouritesService _favouritesService = FavouritesService();
  
  List<String> _favourites = [];
  List<String> get favourites => _favourites;

  FavouritesState() {
    _init();
  }

  _init() async {
    _favourites = await _favouritesService.getFavourites();
    notifyListeners();
  }

  // TODO: method for add favourite, remove favourite
  addFavourite(String favourite) async {
    _favourites = await _favouritesService.addFavourite(favourite);
    notifyListeners();
  }

  removeFavourite(String favourite) async {
    _favourites = await _favouritesService.removeFavourite(favourite);
    notifyListeners();
  }

}