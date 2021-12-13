import 'dart:convert';

class StationStream {
    StationStream({
        required this.name,
        required this.url,
        required this.urlResolved,
        required this.homepage,
        required this.favicon,
        required this.tags,
        required this.bitrate,
        required this.clickCount,
    });

    String name;
    String url;
    String urlResolved;
    String homepage;
    String favicon;
    String tags;
    int bitrate;
    int clickCount;

    factory StationStream.fromRawJson(String str) =>
        StationStream.fromJson(json.decode(str));

    factory StationStream.fromJson(Map<String, dynamic> json) =>
        StationStream(
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