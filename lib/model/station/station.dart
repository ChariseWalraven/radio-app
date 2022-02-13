import 'dart:convert';

class Station {
  Station({
    required this.uuid,
    required this.name,
    required this.url,
    required this.urlResolved,
    required this.homepage,
    required this.favicon,
    required this.tags,
    required this.bitrate,
    required this.clickCount,
  });

  String uuid;
  String name;
  String url;
  String urlResolved;
  String homepage;
  String favicon;
  String tags;
  int bitrate;
  int clickCount;

  factory Station.fromRawJson(String str) => Station.fromJson(json.decode(str));

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        uuid: json["uui"].trim(),
        name: json["name"].trim(),
        url: json["url"].trim(),
        urlResolved: json["url_resolved"].trim(),
        homepage: json["homepage"].trim(),
        favicon: json["favicon"].trim(),
        tags: json["tags"].trim(),
        bitrate: json["bitrate"],
        clickCount: json["clickcount"],
      );
}
