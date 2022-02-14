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
    debugPrint('RadioPlayerState::_getWhatson');
    var t = '';
    var n = '';
    if (_player.playing && _player.icyMetadata != null) {
      t = _player.icyMetadata?.info?.title ?? '';
      n = _player.icyMetadata?.headers?.name ?? '';

      debugPrint('Title: $t. Name: $n.');
    }

    if(t == _title) return;
    if(n == _name) return;
    _title = t;
    _name = n;
    notifyListeners();
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
      _title = 'Error: Cannot play ${newStation.name}';
      // TODO: remove broken stream
      // StreamService.removeStreamByName(newStation);
      _setPlayingState(PlayingState.none);
    }
  }

  Future<void> startPlaying() async {
    if (!_player.playing) {
      try {
        debugPrint(
            'RadioPlayerState.startPlaying.state=${_player.playerState}');
        _setPlayingState(PlayingState.playing);
        await _player.play();
      } catch (e) {
        debugPrint('RadioPlayerState.startPlaying::ERROR::$e');
        _setPlayingState(PlayingState.none);
        _title = 'Error trying to play ${station.name}';
      }
    }
  }

  Future<void> pausePlaying() async {
    if (_player.playing) {
      try {
        _setPlayingState(PlayingState.paused);
        await _player.pause();
        debugPrint('RadioPlayerState.pausePlaying');
      } catch (e) {
        debugPrint('RadioPlayerState.pausePlaying :: ERROR :: $e');
        _setPlayingState(PlayingState.none);
      }
    }
  }

  void _setPlayingState(PlayingState newState) {
    _playingState = newState;
    notifyListeners();
  }

  // begin bottomBar code
  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  void toggleFavourite(String uuid) async {
    debugPrint('AppState::toggleFavourite');
    FavouritesService favService = FavouritesService();
    if(_station.isFavourite) {
      debugPrint('Removing favourite for uuid: $uuid');
      await favService.removeFavourite(uuid);
    }
    else {
      debugPrint('Adding favourite for uuid: $uuid');
      await favService.addFavourite(uuid);
    }
    _station.toggleFavourite();
    
    notifyListeners();
  }
}
