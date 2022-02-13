import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/favourites_state.dart';
import 'package:radio_app/ui/favourites/favourites_list.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: FavouritesList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.remove),
        onPressed: () {
          context.read<FavouritesState>().removeFavourite('test');
          debugPrint('pressed!');
        },
      ),
    );
  }
}
