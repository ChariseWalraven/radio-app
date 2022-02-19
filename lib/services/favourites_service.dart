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
    // setFavourites(["98adecf7-2683-4408-9be7-02d3f9098eb8", "962cc6df-0601-11e8-ae97-52543be04c81", "d28420a4-eccf-47a2-ace1-088c7e7cb7e0", "9712f8c5-2fba-4d5c-a7a9-d094d1adf41b"]);
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

    await setFavourites(_favourites);

    return _favourites;
  }
}