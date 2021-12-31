import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/ui/player/player_bar.dart';
import 'package:radio_app/ui/station/stations_view.dart';
import 'package:radio_app/ui/widgets/bottom_bar.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const StationsView(),
                  PlayerBar(),
                ],
            ),
          ),
        ),
    );
  }
}
