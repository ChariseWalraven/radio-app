import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:radio_app/core/providers/favourites_state.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';
import 'package:radio_app/ui/widgets/tile.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: _playerBuilder);
  }
}

Widget _pauseButton(BuildContext context) {
  AppState state = context.watch<AppState>(); 
  if (state.playingState == PlayingState.playing) {
    return IconButton(
      onPressed: () => state.pausePlaying(),
      icon: const Icon(Icons.pause_circle_filled),
      iconSize: kIconSizeDefault,
    );
  } else if (state.playingState == PlayingState.paused) {
    return IconButton(
      onPressed: () => state.startPlaying(),
      icon: const Icon(Icons.play_circle),
      iconSize: kIconSizeDefault,
    );
  }
  return Container();
}

Widget _favouriteButton(BuildContext context) {
  AppState state = context.watch<AppState>();
  void _handleOnPress() async {
    await state.toggleFavourite(state.station.stationuuid);
    Provider.of<FavouritesState>(context, listen: false).refreshFavourites();
  }

  return IconButton(
    onPressed: _handleOnPress,
    icon: Icon(
        state.station.isFavourite ? Icons.favorite : Icons.favorite_border),
  );
}

class StationNameAndImage extends StatelessWidget {
  const StationNameAndImage({
    Key? key, 
    required this.stationFaviconUrl, 
    required this.stationName,
    required this.stationPlaceholderImagePath,
  }) : super(key: key);

  final String stationFaviconUrl;
  final String stationPlaceholderImagePath;
  final String stationName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: CoverImage(
              imageUrl: stationFaviconUrl,
              placeholderImagePath: stationPlaceholderImagePath,
            ),
          ),
        ),
        Center(
          child: Text(
            stationName,
            maxLines: 2,
            style: TextStyle(
              fontSize: 11 * MediaQuery.of(context).textScaleFactor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}

const Widget _loadingIndicator = Center(child: CircularProgressIndicator());

Widget _playerBuilder(BuildContext context, AppState _state, Widget? _) {
  final double playerHeight = MediaQuery.of(context).size.height * 0.15;

  final PlayingState playingState = _state.playingState;
  final Station station = _state.station;
  final String name = _state.name;

  Widget _child = _loadingIndicator;

  if (playingState != PlayingState.loading) {
    _child = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: StationNameAndImage(
              stationFaviconUrl: station.favicon,
              stationName: name,
              stationPlaceholderImagePath: station.placeholderFavicon,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      _state.title,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _favouriteButton(context),
                    _pauseButton(context),
                  ],
                )
              ],
            ),
          )
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