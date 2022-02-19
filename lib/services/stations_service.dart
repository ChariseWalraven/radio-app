import 'dart:convert';
import 'package:radio_app/model/station/station.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radio_app/model/station/stations_filter.dart';

class StationsService {
  static final List<Station> _tagList = [];

  List<Station> get tagList => _tagList;

  static Future<Station> getStreamByStationUUID(String uuid, {bool isFavourite = false}) async {
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

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var utf = utf8.decode(response.bodyBytes);
        List<dynamic> jsonList = jsonDecode(utf);

        if (jsonList.isEmpty) {
          throw Exception('Station with uuid: $uuid not found.');
        }

        station = Station.fromJson(jsonList[0], isFavourite: isFavourite);
      }
    } catch (e) {
      debugPrint('StationsService::getStreamByStationUUID::ERROR:: $e');
    }

    return station;
  }

  static Future<List<Station>> getStreamsByStationUUID(List<String> uuids,
      {bool isFavourite = false}) async {
    List<Station> stations = [];
    for (var uuid in uuids) {
      Station station =
          await getStreamByStationUUID(uuid, isFavourite: isFavourite);
      stations.add(station);
    }

    return stations;
  }

  static Future<List<Station>> getStreams(StationsFilter filter,
      {bool isUpdate = false, List<String> favouritesList = const []}) async {
    // if favourites list != null, check if it's a favourite
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

        for (Map<String, dynamic> stream in jsonList) {
          bool isFavourite = favouritesList
                  .indexWhere((element) => element == stream["stationuuid"]) >
              -1;

          Station radioStream =
              Station.fromJson(stream, isFavourite: isFavourite);
          int idx = _stations
              .indexWhere((element) => element.name == radioStream.name);
          if (idx < 0) {
            if (_isUrlValid(radioStream.urlResolved)) {
            _stations.add(radioStream);
            }
          } else if (_stations[idx].bitrate < radioStream.bitrate) {
            _stations[idx] = radioStream;
          }
        }
      }
    } catch (e) {
      debugPrint('getStreams::ERROR:: $e');
    }
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
          continue;
        }
      }
    } catch (e) {
      debugPrint('getTags::ERROR:: $e');
    }
    return _tagList.length;
  }
}
