import 'dart:async';
import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/services/favourites_service.dart';

//This is the state manager class for the entire app (stuff that needs to be accessed through the whole app)
class AppState extends ChangeNotifier {
  late final Timer _whatsonTimer;
  final _player = AudioPlayer();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  PlayingState _playingState = PlayingState.none;
  PlayingState get playingState => _playingState;

  Station _station = kDefaultStation;
  Station get station => _station;

  String _name = '';
  String get name => _name;

  String _songTitle = '';
  String get title => _songTitle;

  AppState() {
    _init();
    _whatsonTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      _getWhatson();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _whatsonTimer.cancel();
  }

  void _init() async {
    _setPlayingState(PlayingState.loading);
    notifyListeners();
    _setPlayingState(PlayingState.none);
  }

  void _getWhatson() {
    var t = '';
    var n = '';

    bool somethingChanged = false;

    if (_player.icyMetadata == null) return;

    t = _player.icyMetadata?.info?.title ?? '';
    n = _player.icyMetadata?.headers?.name ?? '';

    t = t == ''? _station.name : t;

    t.trim();
    n.trim();
  

    if(t != _songTitle) {
      _songTitle = t;
      somethingChanged = true;
    }
    if(n != _name) {
      _name = n;
      somethingChanged = true;
    }
    
    if(somethingChanged) {
      notifyListeners();
    }
  }

  Future<void> playStream(Station newStation) async {
    if (newStation == _station) {
      return;
    }
    _station = newStation;
    _setPlayingState(PlayingState.loading); //contains a notifyListeners call
    try {
      if (_player.playing) {
        await _player.stop();
      }
      await _player.setUrl(_station.urlResolved);
      await _player.load();
      await startPlaying();
    } catch (e) {
      debugPrint('RadioPlayerState.playStream::ERROR::$e');
      _songTitle = 'Error: Cannot play ${newStation.name}';
      // TODO: remove broken stream
      // StreamService.removeStreamByName(newStation);
      _setPlayingState(PlayingState.paused);
    }
  }

  Future<void> startPlaying() async {
    if (!_player.playing) {
      try {
        _setPlayingState(PlayingState.playing);
        await _player.play();
      } catch (e) {
        debugPrint('RadioPlayerState.startPlaying::ERROR::$e');        
        _setPlayingState(PlayingState.none);
        _songTitle = 'Error trying to play ${station.name}';
      }
    }
  }

  Future<void> pausePlaying() async {
    if(!_player.playing) return;

    try {
      _setPlayingState(PlayingState.paused);
      await _player.pause();
    } catch (e) {
      debugPrint('RadioPlayerState.pausePlaying :: ERROR :: $e');
      _setPlayingState(PlayingState.none);
    }
  }

  void _setPlayingState(PlayingState newState) {
    if(_playingState != newState) {
      _playingState = newState;
      notifyListeners();
    }
  }

  // begin bottomBar code
  void updateSelectedIndex(int newIndex) {
    if(_selectedIndex != newIndex) {
      _selectedIndex = newIndex;
      notifyListeners();
    }
  }

  Future<void> toggleFavourite(String uuid) async {
    FavouritesService favService = FavouritesService();
    if(_station.isFavourite) {
      await favService.removeFavourite(uuid);
    }
    else {
      await favService.addFavourite(uuid);
    }
    _station.toggleFavourite();
    
    notifyListeners();
  }
}
