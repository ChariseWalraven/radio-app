// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/core/providers/favourites_state.dart';
import 'package:lingo_jam/model/station/station.dart';
import 'package:lingo_jam/ui/widgets/tile.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({Key? key}) : super(key: key);

  final double iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    AppState state = context.watch<AppState>();
    Widget _playPauseButton = Container();

    if (state.playingState == PlayingState.playing) {
      _playPauseButton = IconButton(
        iconSize: iconSize,
        onPressed: state.pausePlaying,
        icon: const Icon(Icons.pause_circle_filled),
      );
    } else if (state.playingState == PlayingState.paused) {
      _playPauseButton = IconButton(
        iconSize: iconSize,
        onPressed: state.startPlaying,
        icon: const Icon(Icons.play_circle),
      );
    }
    return _playPauseButton;
  }
}

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState state = context.watch<AppState>();

    void _handleOnPress() async {
      await state.toggleFavourite(state.station.stationuuid);
      context.read<FavouritesState>().refreshFavourites();
    }

    Color color = Theme.of(context).colorScheme.onBackground;
    IconData icon = Icons.favorite_border;

    if (state.station.isFavourite) {
      color = Theme.of(context).colorScheme.tertiary;
      icon = Icons.favorite;
    }

    return IconButton(
      onPressed: _handleOnPress,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}

class RemoveButton extends StatelessWidget {
  const RemoveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text(
        'Remove',
        style: TextStyle(color: Colors.red),
      ),
      onPressed: context.watch<AppState>().removeAndBlacklistStream,
    );
  }
}

class PlayerButtonBar extends StatelessWidget {
  const PlayerButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      const PlayPauseButton(),
      const FavouriteButton(),
    ];
    if (context.watch<AppState>().playingState == PlayingState.errored) {
      _children = [
        const RemoveButton(),
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _children,
    );
  }
}

class SongNameAndPlayerButtonBar extends StatelessWidget {
  const SongNameAndPlayerButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = context.watch<AppState>().title;
    PlayingState playingState = context.watch<AppState>().playingState;

    String? _errorMessage;

    if (playingState == PlayingState.errored) {
      _errorMessage =
          'Cannot play $title. Remove this station to prevent it from appearing.';
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              _errorMessage ?? title,
              maxLines: 3,
              softWrap: true,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12 * MediaQuery.of(context).textScaleFactor,
              ),
            ),
          ),
        ),
        const PlayerButtonBar(),
      ],
    );
  }
}

class StationNameAndImage extends StatelessWidget {
  const StationNameAndImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState state = context.watch<AppState>();
    Station station = state.station;
    PlayingState playingState = state.playingState;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: CoverImage(
            imageUrl: station.favicon,
            placeholderImagePath: station.placeholderFavicon,
          ),
        ),
        Text(
          playingState != PlayingState.errored ? station.name : "ERROR",
          maxLines: 4,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11 * MediaQuery.of(context).textScaleFactor,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
