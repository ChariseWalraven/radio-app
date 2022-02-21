import 'package:flutter/material.dart';
import 'package:lingo_jam/core/enums/playing_state.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/model/station/station.dart';
import 'package:lingo_jam/services/stations_collection_service.dart';
import 'package:lingo_jam/ui/style/style_constants.dart';
import 'package:lingo_jam/ui/style/style_utils.dart';
import 'package:lingo_jam/ui/widgets/tile.dart';
import 'package:provider/provider.dart';

class FavouritesCollection extends StatelessWidget {
  const FavouritesCollection(
      {Key? key, required this.stationsCollectionService})
      : super(key: key);

  final StationsCollectionService stationsCollectionService;

  @override
  Widget build(BuildContext context) {
    bool playerVisible =
        context.watch<AppState>().playingState != PlayingState.none;

    final double playerHeight = getPlayerHeight(context) + kPlayerHeightMargin;
    return Padding(
      padding: EdgeInsets.only(bottom: playerVisible ? playerHeight : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            child: Text(
              stationsCollectionService.title,
              style: TextStyle(
                fontSize: 16 * MediaQuery.of(context).textScaleFactor,
              ),
            ),
          ),
          Expanded(
            child: VerticalList(
              stations: stationsCollectionService.collection,
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalList extends StatelessWidget {
  const VerticalList({Key? key, required this.stations}) : super(key: key);

  final List<Station> stations;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: stations.length,
      itemBuilder: (BuildContext context, int index) {
        Station station = stations[index];
        return Tile(
          enableCustomBackground: true,
          isFavourite: station.isFavourite,
          placeholderImagePath: station.placeholderFavicon,
          title: station.name,
          onTap: () {
            context
                .read<AppState>()
                .playStream(newStation: station, collection: stations);
          },
          imageUrl: station.favicon,
        );
      },
    );
  }
}
