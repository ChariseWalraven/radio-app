import 'dart:convert';

import 'dart:math';

import 'package:flutter/foundation.dart';

class Station {
   Station({
    required this.stationuuid,
    required this.name,
    required this.url,
    required this.urlResolved,
    required this.homepage,
    required this.favicon,
    required this.tags,
    required this.bitrate,
    required this.clickCount,
    this.isFavourite = false,
  });

  final String stationuuid;
  final String name;
  final String url;
  final String urlResolved;
  final String homepage;
  final String favicon;
  final String tags;
  final int bitrate;
  final int clickCount;
  bool isFavourite;

  factory Station.fromRawJson(String str) => Station.fromJson(json.decode(str));

  factory Station.fromJson(Map<String, dynamic> json, {bool isFavourite = false}) => Station(
        isFavourite: isFavourite,
        stationuuid: json["stationuuid"],
        name: json["name"].trim(),
        url: json["url"].trim(),
        urlResolved: json["url_resolved"].trim(),
        homepage: json["homepage"].trim(),
        favicon: _getFavicon(json),
        tags: json["tags"].trim(),
        bitrate: json["bitrate"],
        clickCount: json["clickcount"],
      );

  void toggleFavourite() {
    isFavourite = !isFavourite;
  }
}


 String _getFavicon(Map<String, dynamic> json) {
    String _favicon =_pickRandomPlaceholder();
    try {
      if(json['favicon'] != '') {
        // if(_isValidFaviconUrl(json['favicon'])) {
          _favicon = json['favicon'];
        // }
      }
    } catch(e) {
      debugPrint('ERROR::$e. favicon url: ${json['favicon']}');
      _favicon = "assets/images/vinyl-record-blue-bg.png";
    }
    return _favicon;
  }

  String _pickRandomPlaceholder() {
    int random = Random().nextInt(4);

    List<String> images = [
      "assets/images/vinyl-record-blue-bg.png",
      "assets/images/vinyl-record-green-bg.png",
      "assets/images/vinyl-record-yellow-bg.png",
      "assets/images/vinyl-record-red-bg.png",
    ];

     return images[random];
  }

  bool _isValidFaviconUrl(String url) {
    RegExp re = RegExp(r'(\.png|\.jpg)');
    return re.hasMatch(url);
  }