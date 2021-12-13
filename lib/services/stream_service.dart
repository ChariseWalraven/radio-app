import 'dart:convert';
import 'package:radio_app/model/station_stream/station_stream.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radio_app/model/station_stream/station_stream_filter.dart';

class StreamService {
  static final List<StationStream> _tagList = [];

  bool isLoading = false;
  bool isLoadingTags = false;
  List<StationStream> get tagList => _tagList;

  Future<List<StationStream>> getStreams(StationStreamFilter filter, {bool isUpdate = false}) async {
    List<StationStream> _stations = [];
    isLoading = true && !isUpdate;
    String url = Uri.encodeFull("https://nl1.api.radio-browser.info/json/stations/search${filter.constructFilterString()}");

    debugPrint('Getting streams from: ${filter.countrycode} $url');
    try {
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var utf = utf8.decode(response.bodyBytes);
        var jsonList = jsonDecode(utf);
        for(var stream in jsonList){
          var radioStream = StationStream.fromJson(stream);
          int idx = _stations.indexWhere((element) => element.name == radioStream.name);
          if(idx < 0) {
            _stations.add(radioStream);
          } else if (_stations[idx].bitrate < radioStream.bitrate){
            _stations[idx] = radioStream;
          }
        }
      }
   
    } catch (e) {
      debugPrint('getStrteams::ERROR:: $e');
    }
    debugPrint('getSTreams.done.streamCount=${_stations.length}');
    isLoading = false;
    return _stations;
  }

  Future<int> getTags() async {
    isLoading = true;
    String url = Uri.encodeFull("http://nl1.api.radio-browser.info/json/tags");
    try {
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var utf = utf8.decode(response.bodyBytes);
        var jsonList = jsonDecode(utf);
        for(var tag in jsonList){
          debugPrint(tag);
        }
      }

    } catch (e) {
      debugPrint('getStrteams::ERROR:: $e');
    }
    debugPrint('getSTreams.done.streamCount=${_tagList.length}');
    isLoading = false;
    return _tagList.length;
  }
 }