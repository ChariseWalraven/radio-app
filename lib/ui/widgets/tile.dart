import 'package:flutter/material.dart';
import 'package:radio_app/ui/widgets/custom_card.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.onTap,
    this.imageUrl = "",
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onTap,
        child: CustomCard(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                    image: imageUrl == "" ? _placeholderImage: _backgroundImage(imageUrl),
                    fit: BoxFit.contain,
                  )
                ),
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }

  final ImageProvider _placeholderImage = const AssetImage("assets/images/music.png");

  ImageProvider _backgroundImage (url) => NetworkImage(url);
}


