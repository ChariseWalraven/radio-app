import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.borderColor,
    this.child,
    this.cornerRadius = 20,
  }) : super(key: key);

  final Color? borderColor;
  final double borderWidth = 2.0;
  final Widget? child;

  final double cornerRadius;
  final double cornerSmoothing = 0.6;
  final Color transparent = const Color(0x00FFFFFF);

  // background
  // border
  // drop shadow
  // fill parent

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color _borderColor = borderColor ?? colorScheme.onBackground;
    final Color _backgroundColor = colorScheme.background;

    // debugPrint('secondary: ${_backgroundColor.toString()}');

    return 
        _card(colorScheme.secondary, _backgroundColor, _borderColor);
  }

  Widget _card(Color shadowColor, Color backgroundColor, Color borderColor) {
    final SmoothRectangleBorder _shape = SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius(
        cornerRadius: cornerRadius,
        cornerSmoothing: cornerSmoothing,
      ),
    );

    return FractionallySizedBox(
      heightFactor: 1,
      widthFactor: 1,
      child: Material(
        color: borderColor,
        shape: _shape,
        clipBehavior: Clip.antiAlias,
        child: FractionallySizedBox(
          heightFactor: 0.985,
          widthFactor: 0.99,
          child: Material(
            shape: _shape,
            clipBehavior: Clip.antiAlias,
            color: shadowColor,
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.8,
              widthFactor: 1,
              child: Material(
                clipBehavior: Clip.antiAlias,
                shape: _shape,
                color: borderColor,
                child: FractionallySizedBox(
                  heightFactor: 0.985,
                  widthFactor: 0.99,
                  child: Stack(children: [
                    FractionallySizedBox(
                      alignment: Alignment.center,
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Material(
                        shape: _shape, 
                        color: backgroundColor,
                        child: FittedBox(
                          alignment: Alignment.center,
                          fit: BoxFit.none,
                          child: child?? const SizedBox()
                          ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
