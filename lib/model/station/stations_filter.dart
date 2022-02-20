// @file:Suppress("SpellCheckingInspection")
// ignore_for_file: non_constant_identifier_names

class StationsFilter {
  const StationsFilter({
    this.name = "",
    this.nameExact = false,
    this.country = "",
    this.countryExact = false,
    this.state = "",
    this.stateExact = false,
    this.language = "",
    this.languageExact = true,
    this.tag = "",
    this.tagExact = false,
    this.tagList = "",
    this.codec = "mp3",
    this.bitrateMin = 0,
    this.bitrateMax = 1000000,
    this.is_https = false,
    this.order = "random",
    this.reverse = false,
    this.offset = 0,
    this.limit = 20,
    this.hidebroken = true,
  });

  final String name;
  final bool nameExact;
  final String country;
  final bool countryExact;
  final String state;
  final bool stateExact;
  final String language;
  final bool languageExact;
  final String tag;
  final bool tagExact;
  final String tagList;
  final String codec;
  final int bitrateMin;
  final int bitrateMax;
  final bool is_https;
  final String order;
  final bool reverse;
  final int offset;
  final int limit;
  final bool hidebroken;

  constructFilterString() => "?name=$name"
      "&nameExact=${nameExact.toString()}"
      "&country=$country"
      "&countryExact=${countryExact.toString()}"
      "&state=$state"
      "&stateExact=${stateExact.toString()}"
      "&language=$language"
      "&languageExact=${languageExact.toString()}"
      "&tag=$tag"
      "&tagExact=${tagExact.toString()}"
      "&tagList=$tagList"
      "&codec=$codec"
      "&bitrateMin=$bitrateMin"
      "&bitrateMax=$bitrateMax"
      "&is_https=$is_https"
      "&order=$order"
      "&reverse=$reverse"
      "&offset=$offset"
      "&limit=$limit"
      "&hidebroken=$hidebroken";

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nameExact': nameExact,
      'country': country,
      'countryExact': countryExact,
      'state': state,
      'stateExact': stateExact,
      'language': language,
      'languageExact': languageExact,
      'tag': tag,
      'tagExact': tagExact,
      'tagList': tagList,
      'codec': codec,
      'bitrateMin': bitrateMin,
      'bitrateMax': bitrateMax,
      'is_https': is_https,
      'order': order,
      'reverse': reverse,
      'offset': offset,
      'limit': limit,
      'hidebroken': hidebroken,
    };
  }

  factory StationsFilter.fromMap(Map<String, dynamic> map) => 
    StationsFilter(
      name: map['name'],
      nameExact: map['nameExact'],
      country: map['country'],
      countryExact: map['countryExact'],
      state: map['state'],
      stateExact: map['stateExact'],
      language: map['language'],
      languageExact: map['languageExact'],
      tag: map['tag'],
      tagExact: map['tagExact'],
      tagList: map['tagList'],
      codec: map['codec'],
      bitrateMin: map['bitrateMin'],
      bitrateMax: map['bitrateMax'],
      is_https: map['is_https'],
      order: map['order'],
      reverse: map['reverse'],
      offset: map['offset'],
      limit: map['limit'],
      hidebroken: map['hidebroken'],
    );
}
