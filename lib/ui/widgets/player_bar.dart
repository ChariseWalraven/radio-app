import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/app_state/radio_player_state.dart';
import 'package:radio_app/core/enums/playing_state.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _playerHeight = MediaQuery
        .of(context)
        .size
        .height / 15;
    var _state = Provider.of<RadioPlayerState>(context);
    return SizedBox(
      height: _state.playingState != PlayingState.none ? _playerHeight : 0,
      child: Center(
        child: _state.playingState == PlayingState.loading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Row(
          children: <Widget>[
            Expanded(
              child: Text(
                  _state.title != '' ? _state
                      .title : _state.station),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  _pauseButton(_state)
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
  Widget _pauseButton(RadioPlayerState state) {
    if (state.playingState == PlayingState.playing) {
      return IconButton(
          onPressed: () => state.pausePlaying(),
          icon: const Icon(FontAwesomeIcons.pause)
      );
    } else if (state.playingState == PlayingState.paused) {
      return IconButton(
          onPressed: () => state.startPlaying(),
          icon: const Icon(FontAwesomeIcons.play)
      );
    }
    return Container();
  }
}
