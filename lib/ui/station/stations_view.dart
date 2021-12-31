import 'package:flutter/material.dart';
// ignore: implementation_imports

class StationsView extends StatefulWidget {
  const StationsView({Key? key}) : super(key: key);


  @override
  State<StationsView> createState() => _StationsViewState();
}

class _StationsViewState extends State<StationsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text('coming soon...')
        ],
      ),
    );
  }
}