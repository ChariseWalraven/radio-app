import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/ui.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: _playerBuilder);
  }
}

const Widget _loadingIndicator = Center(child: CircularProgressIndicator());

Widget _playerBuilder(BuildContext context, AppState _state, Widget? _) {
  final double playerHeight = MediaQuery.of(context).size.height * 0.15;

  final PlayingState playingState = _state.playingState;

  Widget _child = _loadingIndicator;

  if(playingState != PlayingState.loading) {
    _child = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: const [
          Expanded(child: StationNameAndImage()),
          Expanded(flex: 3, child: SongNameAndPlayerButtonBar()),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
    height: _state.playingState != PlayingState.none ? playerHeight : 0,
    child: CustomCard(
      enableShadow: false,
      child: _child,
    ),
  );
}
