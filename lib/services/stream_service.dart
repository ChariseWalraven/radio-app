
import 'dart:convert';

import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radio_app/model/station_stream/station_stream_filter.dart';

class StreamService {
  static final List<StationStream> _streamList = [];

  static bool isLoading = false;
  static List<StationStream> get streamList => _streamList;

  Future<int> getStreams(StationStreamFilter filter) async {
    isLoading = true;
    String url = Uri.encodeFull("https://nl1.api.radio-browser.info/json/stations/search${filter.constructFilterString()}");
    debugPrint(url);
    try {
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var utf = utf8.decode(response.bodyBytes);
        var jsonList = jsonDecode(utf);
        for(var stream in jsonList){
          var radioStream = StationStream.fromJson(stream);
          int idx = _streamList.indexWhere((element) => element.name == radioStream.name);
          if(idx < 0) {
            _streamList.add(radioStream);
          } else if (_streamList[idx].bitrate < radioStream.bitrate){
            _streamList[idx] = radioStream;
          }
        }
        _streamList.sort((a,b)=> a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      }
   
    } catch (e) {
      debugPrint('getStrteams::ERROR:: $e');
    }
    debugPrint('getSTreams.done.streamCount=${_streamList.length}');
    isLoading = false;
    return _streamList.length;
  }

  static void removeStreamByName(String stationName) {
    _streamList.removeWhere((element) =>  element.name == stationName);
    debugPrint('StreamService.removeStreamByName($stationName).idx=${_streamList.indexWhere((element) =>  element.name == stationName)}');
  }
 }