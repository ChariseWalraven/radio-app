import 'package:lingo_jam/services/shared_preferences/shared_preferences_list_service.dart';

class BlacklistService extends SharedPreferencesListService {
  BlacklistService() : super(key: "blacklisted-uuids");
}