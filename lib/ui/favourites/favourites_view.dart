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
        if (favourites.isEmpty) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Favourites',
                    style: TextStyle(
                      fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text('You haven\'t favourited anything yet. 🥺'),
                ),
              ),
            ],
          );
        }
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
