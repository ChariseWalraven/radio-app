import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:radio_app/app_state/radio_player_state.dart';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/ui/widgets/player_bar.dart';
import 'package:radio_app/ui/widgets/app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StationsView extends StatelessWidget {
  StationsView({Key? key}) : super(key: key);

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();


  /// The alignment to be used next time the user scrolls or jumps to an item.
  static double alignment = 0;


  @override
  Widget build(BuildContext context) {
    var _state = Provider.of<RadioPlayerState>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            stationsList(_state),
            if(_state.station != "No station selected") const PlayerBar(),
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

  Widget _nowPlaying(double playerHeight, RadioPlayerState state) {
    return SizedBox(
      height: state.playingState != PlayingState.none ? playerHeight : 0,
      child: Center(
          child: state.playingState == PlayingState.loading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Row(
            children: <Widget>[
              Expanded(
                child: Text(
                    state.title != '' ? state
                        .title : state.station),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    _pauseButton(state)
                  ],
                ),

              ),
            ],
          ),
      ),
    );
  }

  Widget _listBuilder(RadioPlayerState state) =>
      ScrollablePositionedList.builder(
        itemCount: state.stationCount,
        itemBuilder: (context, index) => _item(state, index),
        itemPositionsListener: itemPositionsListener,
        reverse: false,
        scrollDirection: Axis.vertical,
      );

  Widget _item(RadioPlayerState state,
      int index) {
    final StationStream radioStream = state.stationList[index];
    bool isActive = radioStream.name == state.station;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
            color: isActive ? Colors.purple.shade400 : Colors.grey,
            width: isActive ? 4 : 0),
      ),
      elevation: isActive ? 0 : 8,
      child: ListTile(
        onTap: () {
          state.playStream(radioStream.name, radioStream.url);
        },
        title: Text(radioStream.name),
        subtitle: Text(radioStream.tags),
      ),
    );
  }


  Widget stationsList(RadioPlayerState state) =>
      ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          int? lastVisibleItemIndex;
          if (positions.isNotEmpty) {
            // Determine the last visible item by finding the item with the
            // greatest leading edge that is less than 1.  i.e. the last
            // item whose leading edge in visible in the viewport.
            lastVisibleItemIndex = positions
                .where((ItemPosition position) => position.itemLeadingEdge < 1)
                .reduce((ItemPosition max, ItemPosition position) =>
            position.itemLeadingEdge > max.itemLeadingEdge
                ? position
                : max)
                .index;
          }
          if(lastVisibleItemIndex != null && state.stationCount - lastVisibleItemIndex < 8 ) {
            state.updateStreamList();
            debugPrint('Updated stream list');
          }
          return Expanded(
              child: state.isLoadingList
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : _listBuilder(state)
          );
        },
      );

}

