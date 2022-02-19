import 'package:flutter/material.dart';
import 'package:radio_app/ui/favourites/favourites_view.dart';
import 'package:radio_app/ui/widgets/player.dart';
import 'package:radio_app/ui/widgets/bottom_bar.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      bottomSheet: const PlayerBar(),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: FavouritesView(),
        ),
      ),
    );
  }
}
