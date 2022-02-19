import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/favourites_state.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/ui/station/stations_collection.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesState>(
      builder: (BuildContext context, FavouritesState state, Widget? child) {
        List<Station> favourites = state.favourites;
        return StationsCollection(
            stations: favourites,
            title: "Favourites",
            scrollDirection: Axis.vertical,
            );
      },
    );
  }
}
