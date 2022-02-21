import 'package:flutter/foundation.dart';
import 'package:lingo_jam/core/constants/constants.dart';
import 'package:lingo_jam/model/station/station.dart';
import 'package:lingo_jam/model/station/stations_filter.dart';
import 'package:lingo_jam/services/shared_preferences/blacklist_service.dart';
import 'package:lingo_jam/services/shared_preferences/favourites_service.dart';
import 'package:lingo_jam/services/stations_service.dart';

// this class is responsible for keeping track of the stations associated with the filter and title passed to it
// it can also handle favourite stations collections

class StationsCollectionService {
  StationsCollectionService(
      {required this.title,
      this.filter = kDefaultStationsFilter,
      this.isFavouritesList = false}) {
    _init();
  }

  final String title;
  final bool isFavouritesList;
  bool moreStationsAreAvailable = true;

  List<Station> collection = [];
  bool isLoading = false;

  StationsFilter filter = kDefaultStationsFilter;

  final FavouritesService _favouritesService = FavouritesService();
  final BlacklistService _blacklistService = BlacklistService();

  get stations => _fetchStations();

  void _init() async {
    isLoading = true;
    collection = await _fetchStations();
    isLoading = false;
  }

  Future<List<Station>> _fetchStations() async {
    List<String> favouritesList = await _favouritesService.getItems();
    List<String> blacklist = await _blacklistService.getItems();

    if (isFavouritesList) {
      return await StationsService.getStreamsByStationUUID(favouritesList,
          isFavourite: isFavouritesList);
    }

    return await StationsService.getStreams(filter,
        favouritesList: favouritesList, blacklist: blacklist);
  }

  Future<List<Station>> refreshStations({bool isUpdate = false}) async {
    List<Station> _stations;
    if (isUpdate) {
      if (moreStationsAreAvailable) {
        isLoading = true;
        _stations = await _getMoreStations();
        isLoading = false;
        return _stations;
      }
    }
    isLoading = true;
    _stations = await _fetchStations();
    isLoading = false;
    return _stations;
  }

  static void _removeStationByUUID(
      {required String stationuuid, required List<Station> collection}) {
    /// removes station from collection
    collection
        .removeWhere((Station station) => station.stationuuid == stationuuid);
  }

  static void blacklistStationByUUID(
      {required String stationuuid, required List<Station> collection}) {
    /// blacklists and removes station by uuid
    BlacklistService().add(stationuuid);
    _removeStationByUUID(stationuuid: stationuuid, collection: collection);
  }

  Future<List<Station>> _getMoreStations() async {
    /// note: we use this mapping workaround in order to update the filter
    /// because we use it elsewhere as a default value for parameters and
    /// dart complains if you use anything other than a constant for that.
    /// So we just create a new object based on the old one every time we
    /// want to update something. It's not perfect, but it works, so that's
    /// ok for now.

    int newOffset = filter.offset + filter.limit;
    Map<String, dynamic> filterMap = filter.toMap();

    filterMap['offset'] = newOffset;

    filter = StationsFilter.fromMap(filterMap);

    List<Station> newStations = await _fetchStations();

    if (newStations.isEmpty) {
      moreStationsAreAvailable = false;
      if (!kReleaseMode) {
        debugPrint(
            'StationsCollectionService::_getMoreStations. No More stations available. Not fetching anything new.');
      }
      return collection;
    }

    for (Station newStation in newStations) {
      // don't add duplicates
      bool stationExists = collection
          .where((Station station) =>
              station.name == newStation.name &&
              station.urlResolved == newStation.urlResolved)
          .isNotEmpty;

      if (stationExists) continue;

      collection.add(newStation);
    }

    return collection;
  }
}
