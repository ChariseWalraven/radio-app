import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:radio_app/core/providers/favourites_state.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';
import 'package:radio_app/ui/widgets/tile.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double playerHeight = MediaQuery.of(context).size.height * 0.15;
    return Consumer<AppState>(builder: (context, _state, child) {
      return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
        height: _state.playingState != PlayingState.none ? playerHeight : 0,
        child: CustomCard(
          enableShadow: false,
          child: Center(
            child: _state.playingState == PlayingState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: CoverImage(
                                    imageUrl: _state.station.favicon),
                              ),
                              Expanded(
                                child: Text(_state.name),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: Center(child: Text(_state.title)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _favouriteButton(_state, context),
                                  _pauseButton(_state),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }

  Widget _pauseButton(AppState state) {
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

  Widget _favouriteButton(AppState state, BuildContext context) {
    void _handleOnPress() async {
      await state.toggleFavourite(state.station.stationuuid);
      Provider.of<FavouritesState>(context, listen: false)
            .refreshFavourites();
    }
    return IconButton(
      onPressed: _handleOnPress,
      icon: Icon(
          state.station.isFavourite ? Icons.favorite : Icons.favorite_border),
    );
  }
}
