import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:radio_app/model/station/stations_filter.dart';
import 'package:radio_app/services/favourites_service.dart';
import 'package:radio_app/ui/widgets/bottom_bar.dart';
import 'package:radio_app/ui/widgets/player.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StationsFilter filter = StationsFilter();

    return Scaffold(
      bottomSheet: const PlayerBar(),
      bottomNavigationBar: BottomBar(),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // filter.offset = filter.offset + 10;
            },
            child: Text('Add 0 to filter')
          ),
        )
      ),
    );
  }
}

class FavouritesTest extends StatelessWidget {
  const FavouritesTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavouritesService favService = FavouritesService();
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.8,
      widthFactor: 1,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: favService.getFavourites(),
                builder: _favouritesListBuilder),
          ),
          ElevatedButton(
              child: const Text('Add favourite'),
              onPressed: () async {
                List<String> favs = await favService.getFavourites();
                await favService.addFavourite('${favs.length}');
                debugPrint('pressed');
              }),
          ElevatedButton(
            onPressed: () async {
              List<String> favs = await favService.getFavourites();

              debugPrint('removing favourite: ${favs[favs.length - 1]}');
              await favService.removeFavourite(favs[favs.length - 1]);
            },
            child: const Text('Remove most recent favourite'),
          ),
          ElevatedButton(
            child: const Text('Clear favourites'),
            onPressed: () {
              try {
                debugPrint('trying to set favourites to []');
                favService.setFavourites([]);
              } catch (e) {
                debugPrint('ERROR::$e');
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget _favouritesListBuilder(
    BuildContext context, AsyncSnapshot<List<String>> snapshot) {
  const JsonEncoder _jsonEncoder = JsonEncoder.withIndent('  ');
  String result = 'Nothing';
  if (snapshot.hasData) {
    result = _jsonEncoder.convert(snapshot.data);
  } else if (snapshot.hasError) {
    result = 'Whoops, error: ${snapshot.error}';
  }

  return Text(result);
}
