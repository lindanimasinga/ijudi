
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';

import 'package:flutter/material.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/forgot-password-view.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class LoginViewModel extends BaseViewModel {
  final StorageManager storage;
  final ApiService apiService;
  final NotificationService notificationService;
  final SharedPrefStorageManager sharedPrefs;

/*
  final LocalAuthentication _auth = LocalAuthentication();
  List<BiometricType> _availableBiometrics = []; */

  String? _username = "";
  String? _password = "";
  static int tapCount = 0;

  List<Shop>? shops;
  List<Advert>? ads;
  double _fingerPrintIconSise = 52;

  LoginViewModel(
      {required this.storage,
      required this.sharedPrefs,
      required this.apiService,
      required this.notificationService});

  get isUAT => sharedPrefs.testEnvironment;
/*
  authenticate() {
    Future.delayed(Duration(seconds: 1))
        .asStream()
        .asyncExpand((event) => _checkBiometrics().asStream())
        .asyncExpand((canBiometric) =>
            !canBiometric ? Stream.value(false) : _authenticate().asStream())
        .map((authenticated) {
      if (authenticated) {
        if (storage.isLoggedIn) {
          BaseViewModel.analytics
              .logLogin(loginMethod: "cellnumber")
              .then((value) => null);
          Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME,
              (Route<dynamic> route) => false);
        } else {
          username = storage.mobileNumber;
          password = storage.password;
        }
      }
    }).listen((event) {}, onError: (e) {
      log("error");
    });
  }

  @override
  initialize() {
    authenticate();
 /*   _getAvailableBiometrics().asStream().listen((event) {
      availableBiometrics = event;
    });*/
  }

  */

  String? get password => _password;
  set password(String? password) {
    _password = password;
    notifyChanged();
  }

  String? get username => _username;
  set username(String? username) {
    _username = username;
    notifyChanged();
  }

  double get fingerPrintIconSise => _fingerPrintIconSise;
  set fingerPrintIconSise(double fingerPrintIconSise) {
    _fingerPrintIconSise = fingerPrintIconSise;
    notifyChanged();
  }

  /*List<BiometricType> get availableBiometrics => _availableBiometrics;
  set availableBiometrics(List<BiometricType> availableBiometrics) {
    _availableBiometrics = availableBiometrics;
    notifyChanged();
  }

  bool get hasBioMetric =>
      _availableBiometrics.isNotEmpty &&
      storage.mobileNumber != null &&
      storage.mobileNumber.isNotEmpty;

  get bioMetricName => _availableBiometrics.contains(BiometricType.fingerprint)
      ? "fingerprint"
      : "face ID";
  */

  login() {
    if (!allFieldsValid) return;
  }

  register() {
    Navigator.pushNamed(context, RegisterView.ROUTE_NAME);
  }

/* 
  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return false;
    log("has biometric $canCheckBiometrics");
    return canCheckBiometrics && sharedPrefs.viewedIntro;
  }

 Future<List<BiometricType>> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return [];

    return availableBiometrics;
  }

  Future<bool> _authenticate() async {
    log("authenticating");
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return false;
    return authenticated;
  }

  void _cancelAuthentication() {
    _auth.stopAuthentication();
  }
  */

  forgotPassword() {
    Navigator.pushNamed(context, ForgotPasswordView.ROUTE_NAME);
  }

  get allFieldsValid {
    return Utils.validSANumber(username) &&
        password != null &&
        password!.isNotEmpty;
  }

  switchEnvironement() {}
}
