import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';

import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:local_auth/local_auth.dart';

class LoginViewModel extends BaseViewModel {
  
  final StorageManager storage;
  final UkhesheService ukhesheService;
  final ApiService apiService;
  final NotificationService notificationService;

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  
  String _username = "";
  String _password = "";


  List<Shop> shops;
  List<Advert> ads;

  LoginViewModel({
    @required this.ukhesheService,
    @required this.storage,
    @required this.apiService,
    @required this.notificationService});

  @override
  initialize() {
    Future.delayed(Duration(seconds: 1)).asStream()
    .asyncExpand((event) => _checkBiometrics().asStream())
    .asyncExpand((canBiometric) => !canBiometric ? Stream.value(false) : _authenticate().asStream())
    .map((authenticated) {
      if(authenticated) {
        if(storage.isLoggedIn) {
          Navigator.pushNamedAndRemoveUntil(
            context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false);
        } else {
          username = storage.mobileNumber;
          password = storage.password;
        }
      }
    })
    .listen((event) {
      
    }, onError: (e) {
      log("error");
    });
  }

  String get password => _password;
  set password(String password) {
    _password = password;
    notifyChanged();
  }

  String get username => _username;
  set username(String username) {
    _username = username;
    notifyChanged();
  }

  login() {
    progressMv.isBusy = true;      
    ukhesheService.authenticate(username, password).asStream()
    .asyncExpand((res) => apiService.findUserByPhone(username).asStream())
    .listen((data) {
        progressMv.isBusy = false;
        storage.mobileNumber = username;
        storage.password = password;
        log("user Id is ${data.id}");
        storage.saveIjudiUserId(data.id);
        notificationService.updateDeviceUser();
        Navigator.pushNamedAndRemoveUntil(
            context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false);
    }, onError: (handleError) {
      hasError = true;
      errorMessage = handleError.toString();
      //log(handleError);
    }, onDone: () {
      progressMv.isBusy = false;
    });

  }

  register() {
    Navigator.pushNamed(context, RegisterView.ROUTE_NAME);
  }

  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return false;
    log("has biometric $canCheckBiometrics");
    return canCheckBiometrics;
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    _availableBiometrics = availableBiometrics;
  }

  Future<bool> _authenticate() async {
    log("authenticating");
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return false;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    _authorized = message;
    return authenticated;
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }
}
