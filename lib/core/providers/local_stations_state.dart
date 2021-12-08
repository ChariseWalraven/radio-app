import 'package:radio_app/core/providers/stations_state.dart';
import 'package:radio_app/model/station_stream/station_stream_filter.dart';

class LocalStationsState extends StationsState {
  final StationStreamFilter _filter = StationStreamFilter(countrycode: "NL");

  @override
  init() {
    super.filter = _filter;
    super.init();
  }
}