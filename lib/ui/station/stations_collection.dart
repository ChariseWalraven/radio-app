import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/ui/widgets/tile.dart';

class StationsCollection extends StatelessWidget {
  const StationsCollection({
    Key? key,
    required this.stations,
    required this.title,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  final List<Station> stations;
  final String title;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    bool isNotPaused =
        context.watch<AppState>().playingState != PlayingState.none;
    bool isVerticalScroll = scrollDirection == Axis.vertical;
    final double playerHeight = (MediaQuery.of(context).size.height * 0.15) + 5;
    return Padding(
      padding: EdgeInsets.only(
          bottom: isNotPaused && isVerticalScroll ? playerHeight : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16 * MediaQuery.of(context).textScaleFactor,
              ),
            ),
          ),
          isVerticalScroll
              ? Expanded(child: gridViewBuilder())
              : LimitedBox(
                  maxHeight: 190,
                  child: gridViewBuilder(),
                ),
        ],
      ),
    );
  }

  GridView gridViewBuilder() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: scrollDirection == Axis.vertical ? 2 : 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      scrollDirection: scrollDirection,
      itemCount: stations.length,
      itemBuilder: (BuildContext context, int index) {
        Station station = stations[index];
        return Tile(
          enableCustomBackground: true,
          placeholderImagePath: station.placeholderFavicon,
          title: station.name,
          onTap: () {
            context.read<AppState>().playStream(station);
          },
          imageUrl: station.favicon,
        );
      },
    );
  }
}
