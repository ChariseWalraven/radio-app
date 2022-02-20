/*
  Responsible for:
  - initializing the shared preferences pacckage
  - adding items
  - reading items
  - removing items
*/

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesListService {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  final String key;

  SharedPreferencesListService({
    required this.key
  }) {
    _init();
  }

  _init() async {
    return;
  }

  Future<List<String>> getItems() async {
    SharedPreferences _prefs = await _preferences;
    List<String> _favouritesList = _prefs.getStringList(key)?? await setItems([]);

    return _favouritesList;
  }

  Future<List<String>> setItems(List<String> items) async {
    SharedPreferences _prefs = await _preferences;
    await _prefs.setStringList(key, items);

    return getItems();
  }

  Future<List<String>> add(String item) async {
    List<String> _items = await getItems();

    _items.add(item);
    
    await setItems(_items);

    return getItems();
  }

  Future<List<String>> remove(String item) async {
    List<String> _items = await getItems();

    _items.removeWhere((String _item) => _item == item);
  
    await setItems(_items);

    return _items;
  }
}