import 'dart:convert';

class ISOLocale {
  ISOLocale({
    required this.iso6391, 
    required this.name, 
    required this.endonym
  });

  String iso6391;
  String name;
  String endonym;

  factory ISOLocale.romRawJson(String str) =>
        ISOLocale.fromJson(json.decode(str));

  factory ISOLocale.fromJson(Map<String, dynamic> json) =>
        ISOLocale(
            name: json["name"].trim(),
            iso6391: json["iso_639-1"].trim(),
            endonym: json["endonym"].trim(),
        );
}