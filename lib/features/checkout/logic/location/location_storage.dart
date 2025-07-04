import 'saved_location.dart';
import 'package:pharmacy/app_config_provider/cashe_helper.dart';

class LocationStorage {
  static const String _key = 'saved_locations';

  static Future<void> saveLocations(List<SavedLocation> locations) async {
    final jsonString = SavedLocation.encodeList(locations);
    await CashHelper.saveData(key: _key, value: jsonString);
  }

  static List<SavedLocation> loadLocations() {
    final jsonString = CashHelper.getData(key: _key) as String?;
    if (jsonString == null) return [];
    return SavedLocation.decodeList(jsonString);
  }
} 