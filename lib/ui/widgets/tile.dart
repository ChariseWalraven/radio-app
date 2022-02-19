import 'package:flutter/material.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.onTap,
    this.height = 120.0,
    this.width = 120.0,
    this.imageUrl = "",
    this.enableCustomBackground = false,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final bool enableCustomBackground;

  @override
  Widget build(BuildContext context) {
    Widget _withCustomBackground = CustomCard(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: CoverImage(
              imageUrl: imageUrl,
            ),
          ),
          Expanded(
            child: Text(title),
          )
        ],
      ),
    );

    Widget _withoutCustomBackground = Column(
      children: [
        CoverImage(
          imageUrl: imageUrl,
        ),
        Text(title)
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
  const CoverImage({
    Key? key,
    this.imageUrl = "",
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              imageUrl == "" ? _placeholderImage : _backgroundImage(imageUrl),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  final ImageProvider _placeholderImage =
      const AssetImage("assets/images/vinyl-record-blue-bg.png");

  ImageProvider _backgroundImage(String url){
    if(url.startsWith('http')) return NetworkImage(url);
    return AssetImage(url);
  }
}