import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/core/providers/app_state.dart';
import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:radio_app/ui/widgets/tile.dart';

class StationList extends StatelessWidget {
  const StationList({
    Key? key,
    required this.stations,
  }) : super(key: key);

  final List<StationStream> stations;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: stations.length,
            itemBuilder: (BuildContext context, int index) {
              StationStream station = stations[index];
              return Tile(
                  title: station.name,
                  onTap: () {
                    debugPrint('Title tapped: ${station.name}');
                    state.playStream(station.name, station.urlResolved == "" ? station.url: station.urlResolved);
                  },
                  imageUrl: _isValidFaviconUrl(station.favicon)? station.favicon: ""
              );
            }
        );
      }
    );
  }


// TODO: find a way to check if the file is empty (flutter throws an error if you try to display an empty file)
  bool _isValidFaviconUrl(String url) {
    RegExp re = RegExp(r'(\.png|\.jpg)');
    return re.hasMatch(url);
  }
}