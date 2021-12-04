import 'dart:async';
import 'dart:convert';
import 'package:radio_app/core/abstract_classes/order.dart';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:radio_app/model/station_stream/station_stream_filter.dart';
import 'package:radio_app/services/stream_service.dart';


//This is the state manager class for the stations lists on the home page
class StationsListState extends ChangeNotifier {
  int offset = 0;
  static const int limit = 10;

  //We can create getters against any lower level service directly
  //There is no need to keep a copy of the streamlist here

  // general stations list
  StreamService stationsService = StreamService();
  List<StationStream> _stations = [];
  List<StationStream> get stations => _stations;
  int get stationsCount => _stations.length;
  bool get isLoading => stationsService.isLoading;
  List get popularGenreList => stationsService.tagList;
  bool get isLoadingGenreList => stationsService.isLoadingTags;

  // local stations
  StreamService localStationsService = StreamService();
  List<StationStream> _localStations = [];
  List<StationStream> get localStations => _localStations;
  int get localStationsCount => _localStations.length;
  bool get isLoadingLocalList => localStationsService.isLoading;

  // device language stations (english to start with)
  StreamService langStationsService = StreamService();
  List<StationStream> _langStations = [];
  List<StationStream> get langStations => _langStations;
  int get langStationCount => _langStations.length;
  bool get isLoadingLangList => langStationsService.isLoading;

  PlayingState _playingState = PlayingState.none;
  PlayingState get playingState => _playingState;

  final _player = AudioPlayer();

  StationsListState() {
    _init();
  }

  @override
  void dispose() {
    debugPrint('RadioPlayerState.dispose');
    super.dispose();
  }


  void _init() async {
    _setPlayingState(PlayingState.loading);
    notifyListeners();
    StationStreamFilter filter = StationStreamFilter(limit: limit);
    _stations = await stationsService.getStreams(filter);
    // await stationsService.getTags();
    debugPrint('getting local stations...');
    StationStreamFilter localStationFilter = StationStreamFilter(countrycode: "NL", limit: limit, order: Order.clickCount);
    _localStations = await localStationsService.getStreams(localStationFilter);
    debugPrint('Local stream list: ${_localStations[0]}');
    StationStreamFilter deviceLanguageFilter = StationStreamFilter(language: "english", limit: limit, order: Order.clickCount);
    _langStations = await langStationsService.getStreams(deviceLanguageFilter);
    _setPlayingState(PlayingState.none);

    notifyListeners();
    // debugPrint('local station #1: ${jsonEncode(localStations)}\n lang station #1: ${jsonEncode(langStationList)}');
  }

  void updateStreamList() async {
    StationStreamFilter filter = StationStreamFilter(limit: limit, offset: offset);
    await StreamService().getStreams(filter, isUpdate: true);
    notifyListeners();
  }

  void updateStreamListWithFilter(StationStreamFilter filter) async {
    await StreamService().getStreams(filter, isUpdate: true);
    notifyListeners();
  }

  void _setPlayingState(PlayingState newState){
    _playingState = newState;
    notifyListeners();
  }

}
