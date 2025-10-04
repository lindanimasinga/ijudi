import 'dart:convert';
import 'dart:developer';

import 'package:flutter/semantics.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorageManager extends StorageManager {
  late SharedPreferences _prefs;
  static SharedPrefStorageManager? _storageManager;

  static Future<SharedPrefStorageManager> singleton() async {
    if (_storageManager == null) {
      var prefs = await SharedPreferences.getInstance();
      _storageManager = SharedPrefStorageManager._(prefs);
    }
    return _storageManager!;
  }

  SharedPrefStorageManager._(this._prefs);

  @override
  String? findIjudiAccessToken() {
    return _prefs.getString(StorageManager.ACCESS_TOKEN_IJUDI);
  }

  @override
  String? findUkhesheAccessToken() {
    return _prefs.getString(StorageManager.ACCESS_TOKEN_UKHESHE);
  }

  @override
  void saveIjudiAccessToken(String token) {
    if (token.isEmpty) return;
    _prefs.setString(StorageManager.ACCESS_TOKEN_IJUDI, token);
  }

  @override
  void saveUkhesheAccessToken(String token) {
    if (token.isEmpty) return;
    _prefs.setString(StorageManager.ACCESS_TOKEN_UKHESHE, token);
  }

  @override
  bool get isLoggedIn {
    return mobileNumber != null && mobileNumber!.isNotEmpty;
  }

  @override
  Stream clear() {
    return _prefs.clear().asStream();
  }

  @override
  String? get mobileNumber => _prefs.getString(StorageManager.MOBILE);

  @override
  set mobileNumber(String? value) {
    if (value == null || value.isEmpty) return;
    _prefs.setString(StorageManager.MOBILE, value);
  }

  @override
  bool get viewedIntro {
    var value = _prefs.getBool(StorageManager.FIRST_TIME);
    return value != null && value;
  }

  @override
  set viewedIntro(bool? value) {
    if (value == null) return;
    _prefs.setBool(StorageManager.FIRST_TIME, value);
  }

  @override
  String? findUkhesheTokenExpiryDate() {
    return _prefs.getString(StorageManager.UKHESHE_EXPIRY);
  }

  @override
  void saveUkhesheTokenExpiryDate(String value) {
    if (value.isEmpty) return;
    _prefs.setString(StorageManager.UKHESHE_EXPIRY, value);
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
  void saveIjudiUserId(String? id) {
    if (id == null || id.isEmpty) return;
    _prefs.setString(StorageManager.IJUDI_USER_ID, id);
  }

  @override
  String? getIjudiUserId() {
    return _prefs.getString(StorageManager.IJUDI_USER_ID);
  }

  @override
  String? get deviceId => _prefs.getString(StorageManager.IJUDI_DEVICE_ID);

  @override
  set deviceId(String? id) {
    if (id == null || id.isEmpty) return;
    _prefs.setString(StorageManager.IJUDI_DEVICE_ID, id);
  }

  @override
  String? get selectedLocation =>
      _prefs.getString(StorageManager.SELECTED_LOCATION);

  @override
  set selectedLocation(String? name) {
    if (name == null || name.isEmpty) return;
    _prefs.setString(StorageManager.SELECTED_LOCATION, name);
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
  String? password;

  @override
  ProfileRoles? profileRole;

  @override
  List<Shop>? get shops {
    String? shopsJson = _prefs.getString(StorageManager.SHOPS);
    if (shopsJson == null) {
      return null;
    }
    Iterable list = json.decode(shopsJson);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

  @override
  set shops(List<Shop>? shops) {
    if (shops == null || shops.isEmpty) return;
    _prefs.setString(StorageManager.SELECTED_LOCATION, json.encode(shops));
  }
}
