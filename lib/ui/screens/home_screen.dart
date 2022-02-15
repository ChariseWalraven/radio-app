import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/ui/widgets/player.dart';
import 'package:radio_app/ui/station/stations_view.dart';
import 'package:radio_app/ui/widgets/bottom_bar.dart';

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
