import 'package:flutter/material.dart';
import 'package:radio_app/ui/favourites/favourites_view.dart';
import 'package:radio_app/ui/player/player_bar.dart';
import 'package:radio_app/ui/widgets/bottom_bar.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      bottomSheet: PlayerBar(),
      body: const SafeArea(
        child: FavouritesView(),
      ),
    );
  }
}
