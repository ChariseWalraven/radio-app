import 'package:flutter/services.dart' show rootBundle;

// lookup for iso codes, endonyms, and language names

class LocaleService {
  // import json list of all the iso languages and endonyms etc and store as a private var
  final Future<String> _isoJsonList = rootBundle.loadString('iso_639_1_codes.json');

  LocaleService() {
    print(_isoJsonList);
  }
}