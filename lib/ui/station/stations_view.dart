import 'package:flutter/material.dart';
import 'package:radio_app/ui/station/stations_collections.dart';
// ignore: implementation_imports

class StationsView extends StatefulWidget {
  const StationsView({Key? key}) : super(key: key);


  @override
  State<StationsView> createState() => _StationsViewState();
}

class _StationsViewState extends State<StationsView> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: StationsCollections()
    );
  }
}