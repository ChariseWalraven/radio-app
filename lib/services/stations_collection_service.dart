import 'package:flutter/foundation.dart';
import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/model/station/stations_filter.dart';
import 'package:radio_app/services/favourites_service.dart';
import 'package:radio_app/services/stations_service.dart';

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
  List<Station> collection = [];
  final bool isFavouritesList;

  StationsFilter filter = kDefaultStationsFilter;

  final FavouritesService _favouritesService = FavouritesService();

  get stations => _fetchStations();

  void _init() async {
    collection = await _fetchStations();
  }

  Future<List<Station>> _fetchStations() async {
    List<String> favouritesList = await _favouritesService.getFavourites(); 

    if (isFavouritesList) {
      return await StationsService.getStreamsByStationUUID(favouritesList, isFavourite: isFavouritesList);
    }
    return await StationsService.getStreams(filter, favouritesList: favouritesList);
  }

  Future<List<Station>> refreshStations() async {
    return await _fetchStations();
  }
}
