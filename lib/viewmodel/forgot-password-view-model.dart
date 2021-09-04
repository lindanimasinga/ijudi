import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class ForgotPasswordViewModel extends BaseViewModel {

  final ApiService apiService;
  final StorageManager? storageManager;

  String mobileNumber = "";
  String? password  = "";
  String passwordConfirm = "";
  String otpCode = "";
  bool _otpVerified = false;
  bool _changeSucessful = false;

  String _message = "Please enter your mobile number. We will send you a One Time Pin to reset your password";

  ForgotPasswordViewModel({required this.storageManager,
   required this.apiService });

  @override
  initialize() {
    BaseViewModel.analytics
    .logEvent(name: "password.forgot")
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
      showError(error: "Mobile number is not valid.");
      return;
    }

    progressMv!.isBusy = true;
  }

  void passwordReset() {
  }

  
}