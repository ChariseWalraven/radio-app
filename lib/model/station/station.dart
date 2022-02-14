import 'dart:convert';

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
        favicon: json["favicon"].trim(),
        tags: json["tags"].trim(),
        bitrate: json["bitrate"],
        clickCount: json["clickcount"],
      );

  void toggleFavourite() {
    isFavourite = !isFavourite;
  }
}
