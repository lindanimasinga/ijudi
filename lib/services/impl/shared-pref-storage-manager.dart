
import 'dart:developer';

import 'package:flutter/semantics.dart';
import 'package:ijudi/model/profile.dart';
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
  bool get isLoggedIn {
    var token = findUkhesheAccessToken();
    return token != null && token.isNotEmpty && !hasTokenExpired;
  }

  @override
  Stream clear() {
    return _prefs.clear().asStream();
  }

  @override
  String get mobileNumber => _prefs.getString(StorageManager.MOBILE);

  @override
  set mobileNumber(String value) {
    if(value == null || value.isEmpty) return null;
    _prefs.setString(StorageManager.MOBILE, value);
  }

  @override
  bool get viewedIntro  {
    var value = _prefs.getBool(StorageManager.FIRST_TIME);
    return value != null && value;
  }

  @override
  set viewedIntro(bool value) {
    if(value == null) return null;
    _prefs.setBool(StorageManager.FIRST_TIME, value);
  }

  @override
  String findUkhesheTokenExpiryDate() {
      return _prefs.getString(StorageManager.UKHESHE_EXPIRY);
  }
  
  @override
  void saveUkhesheTokenExpiryDate(String value) {
    if(value == null || value.isEmpty) return null;
    _prefs.setString(StorageManager.UKHESHE_EXPIRY, value);
  }

  @override
  bool get hasTokenExpired {
    var ukhesheExpiry = findUkhesheTokenExpiryDate();
    if(ukhesheExpiry == null) return true;
    var ukhesheExpDate = DateTime.parse(ukhesheExpiry);
    print(ukhesheExpDate);
    return ukhesheExpDate.isBefore(DateTime.now().add(Duration(minutes: 1)));
  }

  @override
  void saveIjudiUserId(String id) {
    if(id == null || id.isEmpty) return null;
    _prefs.setString(StorageManager.IJUDI_USER_ID, id);
  }

  @override
  String getIjudiUserId() {
    return _prefs.getString(StorageManager.IJUDI_USER_ID);
  }

  @override
  String get deviceId => _prefs.getString(StorageManager.IJUDI_DEVICE_ID);

  @override
  set deviceId(String id) {
    if(id == null || id.isEmpty) return null;
    _prefs.setString(StorageManager.IJUDI_DEVICE_ID, id);
  }

  @override
  get testEnvironment {
    var value = _prefs.getBool(StorageManager.IS_TEST_ENV);
    return value != null && value;
  }

  @override
  set testEnvironment(bool value) {
    _prefs.setBool(StorageManager.IS_TEST_ENV, value);
  }

  @override
  String password;

  @override
  ProfileRoles profileRole;
  
}
