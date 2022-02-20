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

  Future<List<Station>> refreshStations({bool isUpdate = false}) async {
    if(isUpdate) {
      return await _getMoreStations();
    }
    return await _fetchStations();
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

    collection.addAll(newStations);

    return collection;
  }
}
