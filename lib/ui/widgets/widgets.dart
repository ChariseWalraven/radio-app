// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:lingo_jam/core/providers/stations_state.dart';
import 'package:provider/src/provider.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/core/providers/favourites_state.dart';
import 'package:lingo_jam/model/station/station.dart';

class CoverImage extends StatelessWidget {
  const CoverImage(
      {Key? key, required this.imageUrl, required this.placeholderImagePath})
      : super(key: key);

  final String imageUrl;
  final String placeholderImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _backgroundImage(imageUrl, placeholderImagePath),
    );
  }

  final ImageProvider _placeholderImage =
      const AssetImage("assets/images/vinyl-record-grey.png");

  FadeInImage _backgroundImage(String url, String placeholderImagePath) {
    if(url == "" || url.isEmpty) {
      return FadeInImage(placeholder: _placeholderImage, image: AssetImage(placeholderImagePath));
    }

    if (url.startsWith('http')) {
      return FadeInImage(
          placeholder: AssetImage(placeholderImagePath),
          image: NetworkImage(url),
          fit: BoxFit.contain,
          imageErrorBuilder: (_, _a, _b) {
            return Image.asset(placeholderImagePath);
          });
    }
    return FadeInImage(
        placeholder: AssetImage(placeholderImagePath),
        image: AssetImage(url),
        imageErrorBuilder: (_, _a, _b) {
          debugPrint(placeholderImagePath + " url: " + url);
          return Image.asset(placeholderImagePath);
        });
  }
}

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState state = context.watch<AppState>();

    void _handleOnPress() async {
      await state.toggleFavourite(state.station.stationuuid);
      await context.read<FavouritesState>().refreshFavourites();
      context.read<StationsState>().refreshUI();
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

class SongNameAndPlayerButtonBar extends StatelessWidget {
  const SongNameAndPlayerButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState state = context.watch<AppState>();
    String title = state.title;
    String name = state.name;
    PlayingState playingState = context.watch<AppState>().playingState;

    String? _errorMessage;

    if (playingState == PlayingState.errored) {
      _errorMessage =
          'Cannot play $name. Remove this station to prevent it from appearing.';
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
        const _PlayerButtonBar(),
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


// Private
class _PlayerButtonBar extends StatelessWidget {
  const _PlayerButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      const _PlayPauseButton(),
      const FavouriteButton(),
    ];
    if (context.watch<AppState>().playingState == PlayingState.errored) {
      _children = [
        const _RemoveButton(),
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _children,
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({Key? key}) : super(key: key);

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

class _RemoveButton extends StatelessWidget {
  const _RemoveButton({Key? key}) : super(key: key);

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
