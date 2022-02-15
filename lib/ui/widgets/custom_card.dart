import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.borderColor,
    this.child,
    this.shadowSize = 10,
    this.cornerRadius = 20,
  }) : super(key: key);

  final Color? borderColor;
  final double borderWidth = 4.0;
  final double shadowSize;
  final Widget? child;

  final double cornerRadius;
  final double cornerSmoothing = 0.6;
  final Color transparent = const Color(0x00FFFFFF);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color _borderColor = borderColor ?? colorScheme.onBackground;
    final Color _backgroundColor = colorScheme.background;

    return _card(colorScheme.secondary, _backgroundColor, _borderColor);
  }

  Widget _card(Color shadowColor, Color backgroundColor, Color borderColor) {
    final SmoothRectangleBorder _shape = SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius(
        cornerRadius: cornerRadius,
        cornerSmoothing: cornerSmoothing,
      ),
    );
    return LayoutBuilder(builder: (context, configuration) {
      double shadowHeight = configuration.maxHeight - borderWidth;
      double shadowWidth = configuration.maxWidth - borderWidth - 10;

      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: shadowWidth,
            decoration: ShapeDecoration(
              shape: _shape,
              color: borderColor,
            ),
          ),
          Container(
            height: shadowHeight,
            width: shadowWidth,
            decoration: ShapeDecoration(
              shape: _shape,
              color: shadowColor,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: borderWidth/2),
                height: shadowHeight - shadowSize,
                width: configuration.maxWidth,
                decoration: ShapeDecoration(
                  shape: _shape,
                  color: borderColor,
                ),
              ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: borderWidth/2),
                height: shadowHeight - shadowSize - (borderWidth/2),
                width: configuration.maxWidth - borderWidth,
                decoration: ShapeDecoration(
                  shape: _shape,
                  color: backgroundColor,
                ),
                child: child ?? const SizedBox(),
              ),
          ),
          
        ],
      );
    });
  }
}