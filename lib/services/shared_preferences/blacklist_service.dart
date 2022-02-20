import 'package:radio_app/services/shared_preferences/shared_preferences_list_service.dart';

class BlackListService extends SharedPreferencesListService {
  BlackListService() : super(key: "blacklisted-uuids");
}