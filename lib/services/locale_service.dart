// lookup for iso codes, endonyms, and language names

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:radio_app/model/iso_locale/iso_locale.dart';

class LocaleService {
  // import json list of all the iso languages and endonyms etc and store as a private var

  Future<ISOLocale> getISOLocaleByCode(String iSOCode) async {
    List<ISOLocale> _isoLocales = [];
    String jsonString = await rootBundle.loadString('assets/localization/iso_639_1_codes.json');
    var _jsonList = json.decode(jsonString);

    for(var _json in _jsonList) {
      ISOLocale _isoLocale = ISOLocale.fromJson(_json);
      _isoLocales.add(_isoLocale);
    }
    return _isoLocales.firstWhere((ISOLocale _isoLocale) => _isoLocale.iso6391 == iSOCode);
  }
}