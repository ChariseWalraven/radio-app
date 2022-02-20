import 'package:flutter/material.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.onTap,
    this.height = 120.0,
    this.width = 120.0,
    required this.imageUrl,
    required this.placeholderImagePath,
    this.enableCustomBackground = false,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final String imageUrl;
  final String placeholderImagePath;
  final VoidCallback onTap;
  final bool enableCustomBackground;

  @override
  Widget build(BuildContext context) {
    Widget _withCustomBackground = CustomCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            // flex: title.length > 30 ? 1 : 2,
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
            )
          )
        ],
      ),
    );

    Widget _withoutCustomBackground = Column(
      children: [
        CoverImage(
          imageUrl: imageUrl,
          placeholderImagePath: placeholderImagePath,
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
    required this.imageUrl,
    required this.placeholderImagePath
  }) : super(key: key);

  final String imageUrl;
  final String placeholderImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _backgroundImage(imageUrl, placeholderImagePath),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image:
        //         imageUrl == "" ? _placeholderImage : _backgroundImage(imageUrl),
        //     fit: BoxFit.contain,
        //   ),
        // ),
    );
  }

  final ImageProvider _placeholderImage =
      const AssetImage("assets/images/vinyl-record-greyscale.png");

  FadeInImage _backgroundImage(String url, String placeholderImagePath){
    if(url.startsWith('http')) {
        return FadeInImage(
          placeholder: _placeholderImage, 
          image: NetworkImage(url), 
          imageErrorBuilder: (_, _a, _b) {
            return Image.asset(placeholderImagePath);
          }
        );
    }
    return FadeInImage(placeholder: _placeholderImage, image: AssetImage(url));
  }
}