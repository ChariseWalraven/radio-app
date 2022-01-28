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
  }) : super(key: key);

  final List<Station> stations;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        SizedBox(
          height: 180,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: stations.length,
            itemBuilder: (BuildContext context, int index) {
              Station station = stations[index];
              return Tile(
                  title: station.name,
                  onTap: () {
                    debugPrint('Title tapped: ${station.name}');
                    context.read<AppState>().playStream(station.name, station.urlResolved == "" ? station.url: station.urlResolved);
                  },
                  imageUrl: _isValidFaviconUrl(station.favicon)? station.favicon: ""
              );
            }
          ),
        ),
      ],
    );
  }


// TODO: find a way to check if the file is empty (flutter throws an error if you try to display an empty file)
  bool _isValidFaviconUrl(String url) {
    RegExp re = RegExp(r'(\.png|\.jpg)');
    return re.hasMatch(url);
  }
}