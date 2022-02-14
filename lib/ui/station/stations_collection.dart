import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/model/station/station.dart';
import 'package:radio_app/ui/widgets/tile.dart';

class StationsCollection extends StatelessWidget {
  const StationsCollection({
    Key? key,
    required this.stations,
    required this.title,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  final List<Station> stations;
  final String title;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(title)
        ),
        scrollDirection == Axis.vertical
            ? Flexible(
                fit: FlexFit.loose,
                flex: 20,
                child: gridViewBuilder(),
              )
            : LimitedBox(
                maxHeight: 180,
                child: gridViewBuilder(),
              ),
      ],
    );
  }

// TODO: find a way to check if the file is empty (flutter throws an error if you try to display an empty file)
  bool _isValidFaviconUrl(String url) {
    RegExp re = RegExp(r'(\.png|\.jpg)');
    return re.hasMatch(url);
  }

  GridView gridViewBuilder() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: scrollDirection == Axis.vertical? 2 : 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20, 
      ),
      shrinkWrap: true,
      scrollDirection: scrollDirection,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: stations.length,
      itemBuilder: (BuildContext context, int index) {
        Station station = stations[index];
        return Tile(
            title: station.name,
            onTap: () {
              debugPrint('Title tapped: ${station.name}');
              context.read<AppState>().playStream(station);
            },
            imageUrl:
                _isValidFaviconUrl(station.favicon) ? station.favicon : "");
      },
    );
  }
}
