import 'package:flutter/material.dart';
import 'package:radio_app/ui/widgets/bottom_bar.dart';
// import 'package:figma_squircle/figma_squircle.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.pink,
            child: CustomCard(),
          ),
        ),
      ),
    );
  }
}