import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                height: 217,
                margin: EdgeInsets.symmetric(horizontal:19),
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 0.6,
                    ),
                  ),
                ),
              ),
              Container(
                height: 215,
                margin: EdgeInsets.symmetric(horizontal:20),
                decoration: ShapeDecoration(
                  color: Colors.yellow,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 0.6,
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.symmetric(horizontal:10),
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 0.6,
                    ),
                  ),
                ),
              ),
              Container(
                height: 196,
                margin: EdgeInsets.only(left: 12, right: 12, top: 2),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 0.6,
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}