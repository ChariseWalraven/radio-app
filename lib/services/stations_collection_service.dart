import 'package:flutter/foundation.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/model/station/stations_filter.dart';
import 'package:radio_app/services/stations_service.dart';

// this class is responsible for keeping track of the stations associated with the filter and title passed to it

class StationsCollection {
  StationsCollection({required this.title, required this.filter}) {
    _init();
  }

  String title = "";
  List<Station> collection = [];
  
  StationsFilter filter = StationsFilter();

  get stations => _fetchStations();

  void _init() async {
    debugPrint('StationsCollection::_init');
    collection = await _fetchStations();
  }

  Future<List<Station>> _fetchStations() async {
    debugPrint('StationsCollection::_fetchStations');
    return await StationsService.getStreams(filter); 
  }
}