import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:lingo_jam/core/constants/constants.dart';

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
  String placeholderFavicon = _pickRandomPlaceholder();

  factory Station.fromRawJson(String str) => Station.fromJson(json.decode(str));

  factory Station.fromJson(Map<String, dynamic> json,
          {bool isFavourite = false}) =>
      Station(
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
  String _favicon = _pickRandomPlaceholder();
  String _jsonFavicon = json['favicon'].toString();
  try {
    if (_isValidFavicon(_jsonFavicon)) {
      _favicon = json['favicon'];
    }
  } catch (e) {
    if (!kReleaseMode) {
      debugPrint('ERROR::$e. favicon url: ${json['favicon']}');
    }
    _favicon = "assets/images/vinyl-record-red.png";
  }
  return _favicon;
}

String _pickRandomPlaceholder() {
  int random = Random().nextInt(3);

  List<String> images = [
    "assets/images/vinyl-record-cyan.png",
    "assets/images/vinyl-record-green.png",
    "assets/images/vinyl-record-yellow.png",
  ];

  return images[random];

}

bool _isValidFavicon(String url) {
  bool isValid = true;
  isValid = !_hostIsBlacklisted(url) && _isValidImageFormat(url);

  return isValid;
}


bool _isValidImageFormat(String url) {
  RegExp validFormatsRegex = RegExp('/.*(jpe?g|png|gif|webp|w?bmp)');
  return validFormatsRegex.hasMatch(url);
}


bool _hostIsBlacklisted(String url) {
  bool result = false;
  for (var blacklistedHost in kBlacklistedHosts) {
    if (result == true) break;
    result = url.contains(blacklistedHost); 
  }

  return result;
}