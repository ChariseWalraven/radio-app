// this class is responsible for keeping track of many station collections

import 'package:flutter/foundation.dart';
import 'package:radio_app/core/abstract_classes/order.dart';
import 'package:radio_app/services/stations_collection_service.dart';
import 'package:radio_app/model/station/stations_filter.dart';
import 'package:radio_app/services/locale_service.dart';

// get languages when the app starts up (before you want to access the list in the home screen) possibly in state init

class StationsCollectionsService {

  static final List<String> _defaultLanguages = ['chinese', 'english', 'spanish', 'german', 'arabic'];
  static final List<StationsCollectionService> _collections = [];

  static final LocaleService _localeService = LocaleService();

  static List<StationsCollectionService> get collections => _collections;
  static StationsCollectionService collection(String stationTitle) => _getStationCollectionByTitle(stationTitle);

  static StationsCollectionService _getStationCollectionByTitle(String stationTitle) {
    // TODO: account for title not existing
    return _collections[0];
  }

  static Future<List<StationsCollectionService>> populateCollections() async {
    debugPrint('StationsCollectionsService::populateCollections');
    for(var language in _defaultLanguages) {
      var languageISOCode = await _localeService.getISOLocaleByLanguageName(language);
      var filter = StationsFilter( 
        language: languageISOCode.name.toLowerCase(), 
        order: Order.clickCount, 
        reverse: true
      );
      var stationCollection = StationsCollectionService(title: 'Stations in Language: ${languageISOCode.name}(${languageISOCode.endonym})', filter: filter);

      await stationCollection.stations;
      _collections.add(stationCollection);
    }

    return _collections;
  }
}