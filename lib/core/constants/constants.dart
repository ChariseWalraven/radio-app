import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/model/station/stations_filter.dart';

const String kAppName = "Radio App";
const StationsFilter kDefaultStationsFilter = StationsFilter();
Station kDefaultStation = Station(stationuuid: "", name: "", url: "", urlResolved: "", homepage: "", favicon: "", tags: "", bitrate: 0, clickCount: 0);
const String kFavouritesRouteName = "/favourites";
const String kHomeRouteName =  "/";