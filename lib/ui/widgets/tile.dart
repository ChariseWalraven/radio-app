import 'package:flutter/material.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';

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
    Widget _withCustomBackground = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        ),
        child: CustomCard(
          shadowColor: isFavourite ? Colors.cyan.shade300 : Colors.yellow,
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

class CoverImage extends StatelessWidget {
  const CoverImage(
      {Key? key, required this.imageUrl, required this.placeholderImagePath})
      : super(key: key);

  final String imageUrl;
  final String placeholderImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _backgroundImage(imageUrl, placeholderImagePath),
    );
  }

  final ImageProvider _placeholderImage =
      const AssetImage("assets/images/vinyl-record-grey.png");

  FadeInImage _backgroundImage(String url, String placeholderImagePath) {
    if (url.startsWith('http')) {
      return FadeInImage(
          placeholder: _placeholderImage,
          image: NetworkImage(url),
          fit: BoxFit.contain,
          imageErrorBuilder: (_, _a, _b) {
            return Image.asset(placeholderImagePath);
          });
    }
    return FadeInImage(placeholder: _placeholderImage, image: AssetImage(url));
  }
}
