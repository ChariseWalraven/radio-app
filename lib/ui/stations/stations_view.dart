import 'dart:convert';

import 'package:radio_app/core/constants/constants.dart';
import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:radio_app/app_state/radio_player_state.dart';
import 'package:radio_app/core/enums/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StationsView extends StatelessWidget {
  StationsView({Key? key}) : super(key: key);

  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();


  /// The alignment to be used next time the user scrolls or jumps to an item.
  static double alignment = 0;


  @override
  Widget build(BuildContext context) {
    final _nowPlayingHeight = MediaQuery
        .of(context)
        .size
        .height / 6;

    //Slightly irritating of changeNotifier is that you must call it differently depening on whether 
    //you are calling an method (not requiring 'listen to changes') or want a value that may change requiring to listen (the default)
    //Here I create to state variables one with listen capability and one without.
    //This is then passed down to other functions in this class
    //You don't need to do it this way. You can bass the build context around and then use that
    //to access your state directly: Provider.of<RadioPlayerState>(context)....
    var _state = Provider.of<RadioPlayerState>(context);
    var _stateNoListen = Provider.of<RadioPlayerState>(context, listen: false);

    // itemPositionsListener.itemPositions.addListener(() => );

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [_pauseButton(_state, _stateNoListen)],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _nowPlaying(_nowPlayingHeight, _state),
            stationsList(_state, _stateNoListen),
          ],
        ),
      ),
    );
  }

  Widget _pauseButton(RadioPlayerState state, RadioPlayerState stateNoListen) {
    if (state.playingState == PlayingState.playing) {
      return IconButton(
          onPressed: () => stateNoListen.pausePlaying(),
          icon: const Icon(FontAwesomeIcons.pause)
      );
    } else if (state.playingState == PlayingState.paused) {
      return IconButton(
          onPressed: () => stateNoListen.startPlaying(),
          icon: const Icon(FontAwesomeIcons.play)
      );
    }
    return Container();
  }

  Widget _nowPlaying(double playerHeight, RadioPlayerState state) {
    return SizedBox(
      height: playerHeight,
      child: Center(
          child: state.playingState == PlayingState.loading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Text(
              '${state.station}${state.title.isNotEmpty ? ':\n\n' : ''}${state
                  .title}')
      ),
    );
  }

  Widget _listBuilder(RadioPlayerState state, RadioPlayerState stateNoListen) =>
      ScrollablePositionedList.builder(
        itemCount: state.stationCount,
        itemBuilder: (context, index) => _item(state, stateNoListen, index),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        reverse: false,
        scrollDirection: Axis.vertical,
      );

  Widget _item(RadioPlayerState state, RadioPlayerState stateNoListen,
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
          stateNoListen.playStream(radioStream.name, radioStream.url);
        },
        title: Text(radioStream.name),
        subtitle: Text(radioStream.tags),
      ),
    );
  }


  Widget stationsList(RadioPlayerState state, RadioPlayerState stateNoListen) =>
      ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          int? min;
          int? max;
          if (positions.isNotEmpty) {
            // Determine the first visible item by finding the item with the
            // smallest trailing edge that is greater than 0.  i.e. the first
            // item whose trailing edge in visible in the viewport.
            min = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge
                ? position
                : min)
                .index;
            // Determine the last visible item by finding the item with the
            // greatest leading edge that is less than 1.  i.e. the last
            // item whose leading edge in visible in the viewport.
            max = positions
                .where((ItemPosition position) => position.itemLeadingEdge < 1)
                .reduce((ItemPosition max, ItemPosition position) =>
            position.itemLeadingEdge > max.itemLeadingEdge
                ? position
                : max)
                .index;
          }
          return Expanded(
              child: state.isLoadingList
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : _listBuilder(state, stateNoListen)
          );
        },
      );

}

