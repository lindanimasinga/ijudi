import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class ForgotPasswordViewModel extends BaseViewModel {

  final ApiService apiService;
  final UkhesheService ukhesheService;
  final StorageManager storageManager;

  String mobileNumber = "";
  String password  = "";
  String passwordConfirm = "";
  String otpCode = "";
  bool _otpVerified = false;
  bool _changeSucessful = false;

  String _message = "Please enter your mobile number. We will send you a One Time Pin to reset your password";

  ForgotPasswordViewModel({@required this.storageManager, @required this.apiService, @required this.ukhesheService});

  @override
  initialize() {
    BaseViewModel.analytics
    .logEvent(name: "forgot-password")
    .then((value) => null);
  }

  String get message => _message;

  set message(String message) {
    _message = message;
    notifyChanged();
  }

  bool get otpRequestSent => _otpVerified;
  set otpRequestSent(bool otpVerified) {
    _otpVerified = otpVerified;
    notifyChanged();
  }

  bool get changeSucessful => _changeSucessful;
  set changeSucessful(bool changeSucessful) {
    _changeSucessful = changeSucessful;
    notifyChanged();
  }

  requestPasswordReset() {
    if(mobileNumber.length != 10) {
      hasError = true;
      errorMessage = "Mobile number is not valid.";
      return;
    }

    progressMv.isBusy = true;
    ukhesheService.requestPasswordReset(mobileNumber).asStream()
    .listen((event) {
      otpRequestSent = true;
      
    BaseViewModel.analytics
    .logEvent(name: "forgot-password-success")
    .then((value) => null);

    }, onError: (e) {
      hasError = true;
      errorMessage = e.toString();

      BaseViewModel.analytics
      .logEvent(name: "forgot-password-error")
      .then((value) => {
        {
          "error" : e.toString(),
          "cellNumber" : mobileNumber
        }
      });
    }, onDone:() {
      progressMv.isBusy = false;
    });
  }

  void passwordReset() {

    if(mobileNumber.length != 10) {
      hasError = true;
      errorMessage = "Mobile number is not valid.";
      return;
    }

    if(password != passwordConfirm) {
      hasError = true;
      errorMessage = "Your confirm password does not match";
    }

    progressMv.isBusy = true;
    var request = {
      "identity": mobileNumber,
      "password": password,
      "hash": otpCode
    };

    ukhesheService.resetPassword(request).asStream()
    .listen((event) {
      changeSucessful = true;
      Future.delayed(Duration(seconds: 2))
      .then((value) => Navigator.pop(context));
    }, onError: (e) {
      errorMessage = e.toString();
      hasError = true;
    }, onDone:() {
      progressMv.isBusy = false;
    });
  }

  
}