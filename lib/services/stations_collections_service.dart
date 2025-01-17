// this class is responsible for keeping track of many station collections

import 'package:lingo_jam/core/abstract_classes/order.dart';
import 'package:lingo_jam/services/stations_collection_service.dart';
import 'package:lingo_jam/model/station/stations_filter.dart';
import 'package:lingo_jam/services/locale_service.dart';

// get languages when the app starts up (before you want to access the list in the home screen) possibly in state init

class StationsCollectionsService {
  static final List<String> _defaultLanguages = [
    'chinese',
    'english',
    'spanish',
    'german',
    'arabic',
    'hindi',
    'bengali',
    'indonesian',
    'french',
    'russian',
    'portuguese',
    'japanese',
    'italian',
    'greek',
    'korean',
    'swahili'
  ];
  static final List<StationsCollectionService> _collections = [];

  static final LocaleService _localeService = LocaleService();

  static List<StationsCollectionService> get collections => _collections;
  static StationsCollectionService collection(String stationTitle) =>
      _getStationCollectionByTitle(stationTitle);

  static StationsCollectionService _getStationCollectionByTitle(
      String stationTitle) {
    return _collections
        .firstWhere((collection) => collection.title == stationTitle);
  }

  static Future<List<StationsCollectionService>> populateCollections() async {
    for (var language in _defaultLanguages) {
      var languageISOCode =
          await _localeService.getISOLocaleByLanguageName(language);
      var filter = StationsFilter(
          language: languageISOCode.name.toLowerCase(),
          order: Order.clickCount,
          reverse: true);

      String title = languageISOCode.endonym;

      if (languageISOCode.endonym.toLowerCase() != 'english') {
        title += ' (${languageISOCode.name})';
      }

      var stationCollection =
          StationsCollectionService(title: title, filter: filter);

      await stationCollection.stations;
      _collections.add(stationCollection);
    }

    return _collections;
  }
}
