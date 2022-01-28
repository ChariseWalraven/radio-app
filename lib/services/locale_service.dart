// lookup for iso codes, endonyms, and language names

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:radio_app/model/iso_locale/iso_locale.dart';

class LocaleService {
  // import json list of all the iso languages and endonyms etc and store as a private var

  LocaleService() {
    _init();
  }

    final List<ISOLocale> _isoLocales = [];
    static String _jsonString = "";
    // ignore: prefer_typing_uninitialized_variables
    static List _jsonList = [];

    Future<void> _init() async {
      // adds locales from file to jsonList for use.
      if(_jsonString.isEmpty) {
        _jsonString = await rootBundle.loadString('assets/localization/iso_639_1_codes.json');
        _jsonList = json.decode(_jsonString);
        for(var _json in _jsonList) {
          ISOLocale _isoLocale = ISOLocale.fromJson(_json);
          _isoLocales.add(_isoLocale);
        }
      }
      return;
    }

  Future<ISOLocale> getISOLocaleByCode(String iSOCode) async {
    await _init();
    return _isoLocales.firstWhere((ISOLocale _isoLocale) => _isoLocale.iso6391.toLowerCase() == iSOCode.toLowerCase());
    }

  Future<ISOLocale> getISOLocaleByLanguageName(String isoLanguageName) async {
    await _init();
    return _isoLocales.firstWhere((ISOLocale _isoLocale) => 
      _isoLocale.name.toLowerCase() == isoLanguageName.toLowerCase()
    );
  }
  Future<ISOLocale> getISOLocaleByEndonym(String isoEndonym) async {
    await _init();
    return _isoLocales.firstWhere((ISOLocale _isoLocale) => _isoLocale.iso6391.toLowerCase() == isoEndonym.toLowerCase());
  }
}