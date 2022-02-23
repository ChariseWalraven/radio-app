import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
    this.child,
    this.shadowSize = 5,
    this.cornerRadius = 20,
    this.enableShadow = true,
  }) : super(key: key);

  final Color? borderColor;
  final double borderWidth = 4.0;
  final double shadowSize;
  final Widget? child;
  final Color? shadowColor;
  final bool enableShadow;
  final Color? backgroundColor;

  final double cornerRadius;
  final double cornerSmoothing = 0.6;
  final Color transparent = const Color(0x00FFFFFF);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color _borderColor = borderColor ?? colorScheme.onSurface;
    final Color _backgroundColor = backgroundColor?? colorScheme.surface;
    final Color _shadowColor = shadowColor ?? colorScheme.secondary;

    return _card(_shadowColor, _backgroundColor, _borderColor);
  }

  Widget _card(Color shadowColor, Color backgroundColor, Color borderColor) {
    final SmoothRectangleBorder _shape = SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius(
        cornerRadius: cornerRadius,
        cornerSmoothing: cornerSmoothing,
      ),
    );
    return LayoutBuilder(builder: (context, configuration) {
      double shadowHeight = configuration.maxHeight > 0
          ? configuration.maxHeight - borderWidth
          : configuration.maxHeight;
      double shadowWidth = configuration.maxWidth - borderWidth - 10;

      List<Widget> _withShadow = [
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
            height: shadowHeight > 0 ? shadowHeight - shadowSize + (borderWidth/2): shadowHeight,
            width: configuration.maxWidth,
            decoration: ShapeDecoration(
              shape: _shape,
              color: borderColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: (borderWidth / 2), left: 1, right: 1),
          child: Container(
            height: shadowHeight > 0
                ? shadowHeight - shadowSize - (borderWidth / 2)
                : shadowHeight,
            width: configuration.maxWidth - borderWidth,
            decoration: ShapeDecoration(
              shape: _shape,
              color: backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: child ?? const SizedBox(),
              ),
            ),
          ),
        ),
      ];

      List<Widget> _withoutShadow = [
        Container(
          height: configuration.maxHeight,
          width: configuration.maxWidth,
          decoration: ShapeDecoration(
            shape: _shape,
            color: borderColor,
          ),
        ),
        Container(
          height: configuration.maxHeight > 0
              ? configuration.maxHeight - borderWidth
              : configuration.maxHeight,
          width: configuration.maxWidth > 0
              ? configuration.maxWidth - borderWidth
              : configuration.maxWidth,
          decoration: ShapeDecoration(
            shape: _shape,
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: child ?? const SizedBox(),
          ),
        ),
      ];

      return Stack(
        alignment: Alignment.center,
        children: enableShadow ? _withShadow : _withoutShadow,
      );
    });
  }
}
