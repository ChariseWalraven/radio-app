import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lingo_jam/services/shared_preferences/blacklist_service.dart';
import 'package:lingo_jam/services/shared_preferences/favourites_service.dart';
import 'package:lingo_jam/ui/widgets/bottom_bar.dart';
import 'package:lingo_jam/ui/widgets/player.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: const PlayerBar(),
        bottomNavigationBar: BottomBar(),
        body: const SafeArea(
          child: BlackListTest(),
        ));
  }
}

class BlackListTest extends StatelessWidget {
  const BlackListTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlacklistService blService = BlacklistService();
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.8,
      widthFactor: 1,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: blService.getItems(),
                builder: _favouritesListBuilder),
          ),
          ElevatedButton(
              child: const Text('Add black list item'),
              onPressed: () async {
                List<String> favs = await blService.getItems();
                await blService.add('${favs.length}');
                debugPrint('pressed');
              }),
          ElevatedButton(
            onPressed: () async {
              List<String> favs = await blService.getItems();

              debugPrint('removing black list item: ${favs[favs.length - 1]}');
              await blService.remove(favs[favs.length - 1]);
            },
            child: const Text('Remove most recent black list item'),
          ),
          ElevatedButton(
            child: const Text('Clear black list'),
            onPressed: () {
              try {
                debugPrint('trying to set blacklist to []');
                blService.setItems([]);
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
