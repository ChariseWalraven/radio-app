import 'dart:convert';
import 'package:radio_app/model/station/station.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radio_app/model/station/stations_filter.dart';

class StationsService {
  static final List<Station> _tagList = [];

  List<Station> get tagList => _tagList;

  static Future<Station> getStreamByStationUUID(String uuid) async {
    debugPrint('StationsService::getStreamByStationUUID');

    Station station = Station(
        urlResolved: "",
        bitrate: 0,
        clickCount: 0,
        favicon: "",
        homepage: "",
        stationuuid: "",
        name: "",
        tags: "",
        url: "");

    String url = Uri.encodeFull(
        "https://nl1.api.radio-browser.info/json/stations/byuuid/$uuid");

    debugPrint('Getting stream with uuid $uuid. Url: $url.');

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var utf = utf8.decode(response.bodyBytes);
        List<dynamic> jsonList = jsonDecode(utf);

        if (jsonList.isEmpty) {
          throw Exception('Station with uuid: $uuid not found.');
        }

        station = Station.fromJson(jsonList[0]);
      }
    } catch (e) {
      debugPrint('StationsService::getStreamByStationUUID::ERROR:: $e');
    }

    return station;
  }

  static Future<List<Station>> getStreams(StationsFilter filter,
      {bool isUpdate = false}) async {
    List<Station> _stations = [];
    String url = Uri.encodeFull(
        "https://nl1.api.radio-browser.info/json/stations/search${filter.constructFilterString()}");

    debugPrint(
        'Getting streams in: ${filter.language}, limit: ${filter.limit} $url');
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var utf = utf8.decode(response.bodyBytes);
        List<dynamic> jsonList = jsonDecode(utf);

        for (var stream in jsonList) {
          var radioStream = Station.fromJson(stream);
          int idx = _stations
              .indexWhere((element) => element.name == radioStream.name);
          if (idx < 0) {
            _stations.add(radioStream);
          } else if (_stations[idx].bitrate < radioStream.bitrate) {
            _stations[idx] = radioStream;
          }
        }
      }
    } catch (e) {
      debugPrint('getStreams::ERROR:: $e');
    }
    debugPrint('getStreams.done.streamCount=${_stations.length}');
    return _stations;
  }

  Future<int> getTags() async {
    String url = Uri.encodeFull("http://nl1.api.radio-browser.info/json/tags");
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var utf = utf8.decode(response.bodyBytes);
        var jsonList = jsonDecode(utf);
        for (var tag in jsonList) {
          debugPrint(tag);
        }
      }
    } catch (e) {
      debugPrint('getTags::ERROR:: $e');
    }
    debugPrint('getTags.done.streamCount=${_tagList.length}');
    return _tagList.length;
  }
}
