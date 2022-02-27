import 'package:flutter/material.dart';
import 'package:lingo_jam/ui.dart';

class StationsScreen extends StatelessWidget {
  const StationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LingoAppScaffold(
          child:  StationsView(),
    );
  }
}
