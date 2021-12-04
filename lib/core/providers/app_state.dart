import 'dart:async';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_app/model/station_stream/station_stream_filter.dart';
import 'package:radio_app/services/stream_service.dart';


//This is the state manager class for the entire app (stuff that needs to be accessed through the whole app)
class AppState extends ChangeNotifier {
  late final Timer _whatsonTimer;
  final _player = AudioPlayer();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  PlayingState _playingState = PlayingState.none;
  PlayingState get playingState => _playingState;

  String _station = 'No station selected';
  String get station => _station;

  String _title = '';
  String get title => _title;


  AppState() {
    _init();
    _whatsonTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) { 
      _getWhatson();
    });

  }

  @override
  void dispose() {
    debugPrint('RadioPlayerState.dispose');
    super.dispose();
    _whatsonTimer.cancel();
  }


  void _init() async {
    _setPlayingState(PlayingState.loading);
    notifyListeners();
    _setPlayingState(PlayingState.none);
  }

  void _getWhatson() {
    var _what = '';
    if(_player.playing && _player.icyMetadata != null){
      _what = _player.icyMetadata?.info?.title ?? '';
    }
    if(_what != _title){
      _title = _what;
      debugPrint('RadioPlayerState._getWhatson.changed=$_title');
      notifyListeners();
    }
  }

  Future<void> playStream(String newStation, String url) async {
    if(newStation == _station) {
      return;
    }
    debugPrint('RadioPlayerState.playStream=$newStation');
    _station = newStation;
    _title = '';
    _setPlayingState(PlayingState.loading); //contains a notifyListeners call
    try {
      if(_player.playing) {
        await _player.stop();
      }
      await _player.setUrl(url);
      await _player.load();
      await startPlaying();
    } catch (e) {
      debugPrint('RadioPlayerState.playStream :: ERROR :: $e');
      _station = 'Error: Cannot play $newStation';
      // TODO: remove broken stream
      // StreamService.removeStreamByName(newStation);
      _setPlayingState(PlayingState.none);
    }
  }

  Future<void> startPlaying() async {

    if(!_player.playing){
      try {
        debugPrint('RadioPlayerState.startPlaying.state=${_player.playerState}');
        _setPlayingState(PlayingState.playing);
        await _player.play();
      } catch (e) {
        debugPrint('RadioPlayerState.startPlaying :: ERROR :: $e');
        _setPlayingState(PlayingState.none);
        _station = 'Error trying to play $station';
      }
    }
  }

  Future<void> pausePlaying() async {
    if(_player.playing){
      try {
        _setPlayingState(PlayingState.paused);
        await _player.pause();
        debugPrint('RadioPlayerState.pausePlaying');
      }  catch (e) {
        debugPrint('RadioPlayerState.pausePlaying :: ERROR :: $e');
        _setPlayingState(PlayingState.none);
      }
    }
  }

  void _setPlayingState(PlayingState newState){
    _playingState = newState;
    notifyListeners();
  }

  // begin bottomBar code
  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

}
