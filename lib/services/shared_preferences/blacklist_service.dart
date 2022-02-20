import 'package:radio_app/services/shared_preferences/shared_preferences_list_service.dart';

class BlacklistService extends SharedPreferencesListService {
  BlacklistService() : super(key: "blacklisted-uuids");
}