import 'package:flutter/material.dart';
import 'package:lingo_jam/ui.dart';

class LingoAppScaffold extends StatelessWidget {
  const LingoAppScaffold({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      bottomSheet: const PlayerBar(),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kHorizontalScreenPadding),
          child: child,
        ),
      ),
    );
  }
}
