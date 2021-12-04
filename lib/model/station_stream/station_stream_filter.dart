// @file:Suppress("SpellCheckingInspection")
// ignore_for_file: non_constant_identifier_names

class StationStreamFilter {

  StationStreamFilter ({
    this.name = "",
    this.nameExact = false,
    this.country = "",
    this.countryExact = false,
    this.countrycode = "",
    this.state = "",
    this.stateExact = false,
    this.language = "",
    this.languageExact = false,
    this.tag = "",
    this.tagExact = false,
    this.tagList = "",
    this.codec = "mp3",
    this.bitrateMin = 0,
    this.bitrateMax = 1000000,
    // this.has_geo_info = "false" ,
    // this.has_extended_info = "false",
    this.is_https = false,
    this.order = "random",
    this.reverse = false,
    this.offset = 0,
    this.limit = 10000,
    this.hidebroken = false,
  });

  String name;
  bool nameExact;
  String country;
  bool countryExact;
  String countrycode;
  String state;
  bool stateExact;
  String language;
  bool languageExact;
  String tag;
  bool tagExact;
  String tagList;
  String codec;
  int bitrateMin;
  int bitrateMax;
  // String has_geo_info;
  // String has_extended_info;
  bool is_https;
  String order;
  bool reverse;
  int offset;
  int limit;
  bool hidebroken;

  constructFilterString() => "?name=$name"
  "&nameExact=${nameExact.toString()}"
  "&country=$country"
  "&countryExact=${countryExact.toString()}"
  "&countrycode=${countrycode.toString()}"
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
  // "&has_extended_geo_info=$has_extended_info"
  // "&has_geo_info=$has_geo_info"
  "&is_https=$is_https"
  "&order=$order"
  "&reverse=$reverse"
  "&offset=$offset"
  "&limit=$limit"
  "&hidebroken=$hidebroken";
}