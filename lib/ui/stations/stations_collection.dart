import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lingo_jam/core/providers/stations_state.dart';
import 'package:lingo_jam/services/stations_collection_service.dart';
import 'package:provider/provider.dart';
import 'package:lingo_jam/core/providers/app_state.dart';
import 'package:lingo_jam/model/station/station.dart';
import 'package:lingo_jam/ui.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StationsCollection extends StatelessWidget {
  const StationsCollection({
    Key? key,
    required this.stationsCollectionService,
    this.collectionIndex = 0,
  }) : super(key: key);

  final StationsCollectionService stationsCollectionService;
  final int collectionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(
            height: 200,
            width: 400,
            child: PositionedList(
              collectionIndex: collectionIndex,
              isLoading: stationsCollectionService.isLoading,
              moreStationsAreAvailable:
                  stationsCollectionService.moreStationsAreAvailable,
              stations: stationsCollectionService.collection,
            )),
      ],
    );
  }
}

class PositionedList extends StatelessWidget {
  const PositionedList(
      {Key? key,
      required this.stations,
      required this.isLoading,
      required this.moreStationsAreAvailable,
      required this.collectionIndex})
      : super(key: key);

  final List<Station> stations;
  final bool isLoading;
  final bool moreStationsAreAvailable;
  final int collectionIndex;

  void playNewStation(BuildContext context, Station station) async {

    await context.read<AppState>().playStream(newStation: station, collection: stations);
  }

  @override
  Widget build(BuildContext context) {
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

    itemPositionsListener.itemPositions.addListener(() async {
      int lastIndex = itemPositionsListener.itemPositions.value.last.index;
      bool shouldFetchMoreStations = stations.length - (lastIndex + 1) < 2;

      if (shouldFetchMoreStations && moreStationsAreAvailable) {
        if (!kReleaseMode) {
          debugPrint('fetching more stations. lastIndex: $lastIndex');
        }
        await context.read<StationsState>().updateStreamList(collectionIndex);
      }
    });
    return ScrollablePositionedList.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stations.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == stations.length) {
          return isLoading
              ? const SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox();
        }
        Station station = stations[index];
        // return Text('placeholder');
        return Tile(
          maxWidth: 180,
          enableCustomBackground: true,
          isFavourite: station.isFavourite,
          placeholderImagePath: station.placeholderFavicon,
          title: station.name,
          onTap: () => playNewStation(context, station),
          imageUrl: station.favicon,
        );
      },
      itemPositionsListener: itemPositionsListener,
    );
  }
}
