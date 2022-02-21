import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lingo_jam/core/providers/favourites_state.dart';
import 'package:lingo_jam/model/station/station.dart';
import 'package:lingo_jam/ui/station/stations_collection.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesState>(
      builder: (BuildContext context, FavouritesState state, Widget? child) {
        List<Station> favourites = state.favourites;
        return StationsCollection(
            stations: favourites,
          isLoading: state.isLoading,
            title: "Favourites",
            scrollDirection: Axis.vertical,
            );
      },
    );
  }
}
