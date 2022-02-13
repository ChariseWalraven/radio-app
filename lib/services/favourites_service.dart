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
  FavouritesService() {
    _init();
  }

  List<String> _favorites = [];
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  _init() {
    _sharedPreferences.then((value) => 
      debugPrint(value.toString())
    );
  }
}