import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/ui/player/player_bar.dart';

class BottomBar extends StatelessWidget {
  BottomBar({
    Key? key
  }) : super(key: key);

  final List<IconLink> navigationLinks = [];

  @override
  Widget build(BuildContext context) {
      return Consumer<AppState>(
        builder: (context, appState, child) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favourites",
              ),
            ],
          );
        }
    );
  }
}

class IconLink extends StatelessWidget {
  const IconLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
