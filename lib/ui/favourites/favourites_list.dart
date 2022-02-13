import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/favourites_state.dart';

class FavouritesList extends StatelessWidget {
  const FavouritesList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesState>(
      builder: (BuildContext context, FavouritesState state, Widget? child) {
        List<String> favourites = state.favourites;
        debugPrint('state: ${favourites.length}');
        return ListView.builder(
          itemCount: state.favourites.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int i) {
            return Text("Favourite UUID: ${favourites[i]}");
          },
        );
      },
    );
  }
}