import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:lingo_jam/core/constants/constants.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lingo_jam/model/station/station.dart';
import 'package:lingo_jam/services/shared_preferences/favourites_service.dart';
import 'package:lingo_jam/services/stations_collection_service.dart';

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

  List<Station> _currentCollection = [];

  Future? loadingTimeout;

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
    _addPlayerListeners();
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

    t = t == '' ? _station.name : t;

    t.trim();
    n.trim();

    if (t != _songTitle) {
      _songTitle = t;
      somethingChanged = true;
    }
    if (n != _name) {
      _name = n;
      somethingChanged = true;
    }

    if (somethingChanged) {
      notifyListeners();
    }
  }

  Future<void> playStream(
      {required Station newStation, required List<Station> collection}) async {
    if (newStation == _station) {
      return;
    }
    _station = newStation;
    _currentCollection = collection;
    _setPlayingState(PlayingState.loading);

    // ignore any old timeouts; if someone switches between
    // stations before they're done loading it can cause false
    // timeouts
    if (loadingTimeout != null) loadingTimeout!.ignore();

    loadingTimeout =
        Future.delayed(const Duration(milliseconds: 5000), () async {
      if (_playingState == PlayingState.loading) {
        await _player.stop();
        _setPlayingState(PlayingState.errored);
      }
    });

    try {
      if (_player.playing) {
        await _player.stop();
        notifyListeners();
      }
      await _player.setUrl(_station.urlResolved);
      await _player.load();
      await startPlaying();
    } catch (e) {
      if (!kReleaseMode) {
        debugPrint('PlayerState.playStream::ERROR::$e');
      }
      _setPlayingState(PlayingState.errored);
    }
  }

  Future<void> startPlaying() async {
    if (!_player.playing) {
      try {
        _setPlayingState(PlayingState.playing);
        await _player.play();
      } catch (e) {
        if (!kReleaseMode) {
          debugPrint('RadioPlayerState.startPlaying::ERROR::$e');
        }
        _setPlayingState(PlayingState.errored);
      }
    }
  }

  void removeAndBlacklistStream() {
    StationsCollectionService.blacklistStationByUUID(
        collection: _currentCollection, stationuuid: station.stationuuid);
    _setPlayingState(PlayingState.none); // set to none to reset player bar
  }

  Future<void> pausePlaying() async {
    if (!_player.playing) return;

    try {
      _setPlayingState(PlayingState.paused);
      await _player.pause();
    } catch (e) {
      if(!kReleaseMode) {
      debugPrint('RadioPlayerState.pausePlaying :: ERROR :: $e');
      }
      _setPlayingState(PlayingState.none);
    }
  }

  void _setPlayingState(PlayingState newState) {
    if (_playingState != newState) {
      _playingState = newState;
      notifyListeners();
    }
  }

  // begin bottomBar code
  void updateSelectedIndex(int newIndex) {
    if (_selectedIndex != newIndex) {
      _selectedIndex = newIndex;
      notifyListeners();
    }
  }

  Future<void> toggleFavourite(String uuid) async {
    FavouritesService favService = FavouritesService();
    if (_station.isFavourite) {
      await favService.remove(uuid);
    } else {
      await favService.add(uuid);
    }
    _station.toggleFavourite();

    notifyListeners();
  }

  _addPlayerListeners() {
    // TODO: move some code that's dependent on events here to optimise the app state
    _player.playbackEventStream.listen((PlaybackEvent? event) {
      if(!kReleaseMode) {
      debugPrint(
          "AppState::_addPlayerListeners. metadata: ${event.toString()}");
      }
    }, onError: (Object e, StackTrace stack) {
      if(!kReleaseMode) {
      debugPrint('AppState::_addPlayerListeners::ERROR: $e');
      }
    });
  }
}
