
import 'package:ijudi/services/storage-manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorageManager extends StorageManager {

  SharedPreferences _prefs;
  static StorageManager _storageManager;

  static Future<StorageManager> singleton() async {
    if(_storageManager == null) {
      var prefs = await SharedPreferences.getInstance();
      _storageManager = SharedPrefStorageManager._(prefs);
    }
    return _storageManager;
  }

  SharedPrefStorageManager._(this._prefs);

  @override
  String findIjudiAccessToken() {
    return _prefs.getString(StorageManager.ACCESS_TOKEN_IJUDI);
  }

  @override
  String findUkhesheAccessToken() {
    return _prefs.getString(StorageManager.ACCESS_TOKEN_UKHESHE);
  }

  @override
  void saveIjudiAccessToken(String token) {
    if(token == null || token.isEmpty) return null;
    _prefs.setString(StorageManager.ACCESS_TOKEN_IJUDI, token);
  }

  @override
  void saveUkhesheAccessToken(String token) {
    if(token == null || token.isEmpty) return null;
    _prefs.setString(StorageManager.ACCESS_TOKEN_UKHESHE, token);
  }

  @override
  bool isLoggedIn() {
    var token = findUkhesheAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  void clear() {
    _prefs.clear();
  }

  @override
  String get mobileNumber => _prefs.getString(StorageManager.MOBILE);

  @override
  set mobileNumber(String value) {
    if(value == null || value.isEmpty) return null;
    _prefs.setString(StorageManager.MOBILE, value);
  }
}
