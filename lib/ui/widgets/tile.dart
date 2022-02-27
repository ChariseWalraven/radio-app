import 'package:flutter/material.dart';
import 'package:lingo_jam/ui.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.onTap,
    this.maxHeight = 150.0,
    this.maxWidth = 150.0,
    required this.imageUrl,
    required this.placeholderImagePath,
    this.enableCustomBackground = false,
    this.isFavourite = false,
  }) : super(key: key);

  final double maxHeight;
  final double maxWidth;
  final String title;
  final bool isFavourite;
  final String imageUrl;
  final String placeholderImagePath;
  final VoidCallback onTap;
  final bool enableCustomBackground;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget _withCustomBackground = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        ),
        child: CustomCard(
          shadowColor: isFavourite
              ? theme.colorScheme.tertiary
              : theme.colorScheme.secondary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: CoverImage(
                  imageUrl: imageUrl,
                  placeholderImagePath: placeholderImagePath,
                ),
              ),
              Text(
                title,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ));

    Widget _withoutCustomBackground = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CoverImage(
            imageUrl: imageUrl,
            placeholderImagePath: placeholderImagePath,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onTap,
        child: enableCustomBackground
            ? _withCustomBackground
            : _withoutCustomBackground,
      ),
    );
  }
}
