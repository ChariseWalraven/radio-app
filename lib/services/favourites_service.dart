/*
  Responsible for:
  - initializing the shared preferences pacckage
  - adding favorites
  - reading favorites
  - removing favorites
*/

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesService {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  final String _favouritesKey = "favourite-station-uuids";

  FavouritesService() {
    _init();
  }

  _init() async {
    // add dummy favourites
    setFavourites(["962c17fc-fa99-4aef-9e41-93f711b4ebf0", "960d6459-0601-11e8-ae97-52543be04c81", "962c17fc-fa99-4aef-9e41-93f711b4ebf0", "960d6459-0601-11e8-ae97-52543be04c81", "962c17fc-fa99-4aef-9e41-93f711b4ebf0", "960d6459-0601-11e8-ae97-52543be04c81", "962c17fc-fa99-4aef-9e41-93f711b4ebf0", "960d6459-0601-11e8-ae97-52543be04c81"]);
  }

  Future<List<String>> getFavourites() async {
    // get favourites list
    SharedPreferences _prefs = await _preferences;
    List<String>_favouritesList = _prefs.getStringList(_favouritesKey)?? await setFavourites([]);

    return _favouritesList;
  }

  Future<List<String>> setFavourites(List<String> favourites) async {
    SharedPreferences _prefs = await _preferences;
    _prefs.setStringList(_favouritesKey, favourites);

    return getFavourites();
  }

  Future<List<String>> addFavourite(String favourite) async {
    List<String> _favourites = await getFavourites();
    _favourites.add(favourite);
    
    setFavourites(_favourites);

    return getFavourites();
  }

  Future<List<String>> removeFavourite(String favourite) async {
    // get favourites and pop the item passed
    List<String> _favourites = await getFavourites();

    _favourites.removeWhere((String item) => item == favourite);

    debugPrint(_favourites.toString());

    await setFavourites(_favourites);

    return _favourites;
  }
}