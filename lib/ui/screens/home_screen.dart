import 'package:flutter/material.dart';
import 'package:lingo_jam/ui/widgets/player.dart';
import 'package:lingo_jam/ui/station/stations_view.dart';
import 'package:lingo_jam/ui/widgets/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      bottomSheet: const PlayerBar(),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:  StationsView()
        ),
      ),
    );
  }
}
