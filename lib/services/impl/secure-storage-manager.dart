import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/services/storage-manager.dart';

class SecureStorageManager extends StorageManager {
  FlutterSecureStorage _prefs;
  static SecureStorageManager _storageManager;
  Map<String, String> _storeMap = {};

  static Future<StorageManager> singleton() async {
    if (_storageManager == null) {
      var store = FlutterSecureStorage();
      _storageManager = SecureStorageManager._(store);
      await _storageManager.initialize();
    }
    return _storageManager;
  }

  SecureStorageManager._(FlutterSecureStorage store) {
    _prefs = store;
  }

  Future initialize() async {
    return _prefs.readAll();
  }

  Future _readAll() async {
    _storeMap = await _prefs.readAll();
    log("keys are ${json.encode(_storeMap)}");
  }

  void _save(String key, String value) {
    _prefs
        .write(key: key, value: value)
        .asStream()
        .map((value) => log("$key saved!"))
        .asyncExpand((value) => _readAll().asStream())
        .listen((event) {});
  }

  @override
  String findIjudiAccessToken() {
    return _storeMap[StorageManager.ACCESS_TOKEN_IJUDI];
  }

  @override
  String findUkhesheAccessToken() {
    return _storeMap[StorageManager.ACCESS_TOKEN_UKHESHE];
  }

  @override
  void saveIjudiAccessToken(String token) {
    if (token == null || token.isEmpty) return null;
    _save(StorageManager.ACCESS_TOKEN_IJUDI, token);
  }

  @override
  void saveUkhesheAccessToken(String token) {
    if (token == null || token.isEmpty) return null;
    _save(StorageManager.ACCESS_TOKEN_UKHESHE, token);
  }

  @override
  bool get isLoggedIn {
    return mobileNumber != null && mobileNumber.isNotEmpty;
  }

  @override
  Stream clear() {
    return _prefs
        .deleteAll()
        .asStream()
        .map((event) {
          /*_save(StorageManager.UKHESHE_PASSWORD,
              _storeMap[StorageManager.UKHESHE_PASSWORD]);
          _save(StorageManager.MOBILE, _storeMap[StorageManager.MOBILE]);*/
          _save(StorageManager.IJUDI_DEVICE_ID,
              _storeMap[StorageManager.IJUDI_DEVICE_ID]);
        })
        .map((event) => _storeMap.clear())
        .asyncExpand((event) => _readAll().asStream());
  }

  @override
  String get mobileNumber => _storeMap[StorageManager.MOBILE];

  @override
  set mobileNumber(String value) {
    if (value == null || value.isEmpty) return null;
    _save(StorageManager.MOBILE, value);
  }

  @override
  String findUkhesheTokenExpiryDate() {
    return _storeMap[StorageManager.UKHESHE_EXPIRY];
  }

  @override
  void saveUkhesheTokenExpiryDate(String value) {
    if (value == null || value.isEmpty) return null;
    _save(StorageManager.UKHESHE_EXPIRY, value);
  }

  @override
  bool get hasTokenExpired {
    var ukhesheExpiry = findUkhesheTokenExpiryDate();
    if (ukhesheExpiry == null) return true;
    var ukhesheExpDate = DateTime.parse(ukhesheExpiry);
    print(ukhesheExpDate);
    return ukhesheExpDate.isBefore(DateTime.now().add(Duration(minutes: 1)));
  }

  @override
  void saveIjudiUserId(String id) {
    if (id == null || id.isEmpty) return null;
    _save(StorageManager.IJUDI_USER_ID, id);
  }

  @override
  String getIjudiUserId() {
    return _storeMap[StorageManager.IJUDI_USER_ID];
  }

  @override
  String get deviceId => _storeMap[StorageManager.IJUDI_DEVICE_ID];

  @override
  set deviceId(String id) {
    if (id == null || id.isEmpty) return null;
    _save(StorageManager.IJUDI_DEVICE_ID, id);
  }

  @override
  get password => _storeMap[StorageManager.UKHESHE_PASSWORD];

  @override
  set password(String value) {
    _save(StorageManager.UKHESHE_PASSWORD, value);
  }

  @override
  ProfileRoles get profileRole {
    var stringEnum = _storeMap[StorageManager.PROFILE_ROLE];
    return stringEnum == null
        ? null
        : ProfileRoles.values
            .singleWhere((item) => item.toString() == stringEnum, orElse: null);
  }

  @override
  set profileRole(ProfileRoles value) {
    _save(StorageManager.PROFILE_ROLE, value.toString());
  }

  @override
  String get selectedLocation => _storeMap[StorageManager.SELECTED_LOCATION];

  @override
  set selectedLocation(String name) {
    if (name == null || name.isEmpty) return null;
    _save(StorageManager.SELECTED_LOCATION, name);
  }
}
