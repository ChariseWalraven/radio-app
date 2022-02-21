import 'package:lingo_jam/services/shared_preferences/shared_preferences_list_service.dart';

/*
  Responsible for:
  - initializing the shared preferences pacckage
  - adding favorites
  - reading favorites
  - removing favorites
*/

class FavouritesService extends SharedPreferencesListService {
  FavouritesService() : super(key: 'favourite-station-uuids');  
}