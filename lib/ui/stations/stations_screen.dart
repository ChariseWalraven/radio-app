import 'package:flutter/material.dart';
import 'package:lingo_jam/ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      bottomSheet: const PlayerBar(),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalScreenPadding),
          child:  StationsView()
        ),
      ),
    );
  }
}
