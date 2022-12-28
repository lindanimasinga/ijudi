import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class RegisterViewModel extends BaseViewModel {
  final ApiService apiService;
  final StorageManager? storage;
  final NotificationService? notificationService;

  String? otp;
  final String _aboutUkheshe =
      "By signing up, I agree to the terms and conditions below.";

  bool passwordValid = true;
  bool mobileNumberValid = true;
  bool nameValid = true;
  bool lastNameValid = true;
  var idNumberValid = true;
  SignUpReason _interests = SignUpReason.BUY;
  String idNumber = "";
  String name = "";
  String lastname = "";
  String description = "";
  int yearsInService = 0;
  String? email;
  String? _address = "";
  String imageUrl =
      "https://izinga-aut.s3.af-south-1.amazonaws.com/images/user.png";
  int likes = 0;
  int servicesCompleted = 0;
  int badges = 0;
  String mobileNumber = "";
  String role = "";
  int responseTimeMinutes = 0;
  String? password;
  String? passwordConfirm;
  bool _hasUkheshe = false;
  bool isFirstTimeUser;

  RegisterViewModel(
      {
      required this.apiService,
      required this.storage,
      required this.notificationService,
      this.isFirstTimeUser = false,
      String? address}) {
    _address = address;
  }

  bool get hasUkheshe => _hasUkheshe;
  set hasUkheshe(bool hasUkheshe) {
    _hasUkheshe = hasUkheshe;
    notifyChanged();
  }

  String? get address => _address;
  set address(String? address) {
    _address = address;
    notifyChanged();
  }

  SignUpReason get interests => _interests;

  set interests(SignUpReason interests) {
    _interests = interests;
    notifyChanged();
  }

  String? bankName;
  String? bankAccountNumber;
  String? bankAccountType;
  String? bankCellNumber;
  Bank _bank = Bank(name: null, accountId: null, type: null);

  String get ukhesheMessage => _aboutUkheshe;

  signupUser() {
    if (!allFieldsValid) return;

    _bank.name = "FNB";
    _bank.phone = mobileNumber;
    _bank.type = BankAccType.EWALLET;

    var user = UserProfile(
        name: name,
        surname: lastname,
        idNumber: idNumber,
        description: "customer",
        imageUrl: imageUrl,
        mobileNumber: mobileNumber,
        address: address,
        role: ProfileRoles.CUSTOMER,
        bank: _bank);

    progressMv!.isBusy = true;
    apiService
        .findUserByPhone(mobileNumber)
        .catchError((error) => log("user does not exist."))
        .asStream()
        .asyncExpand((existingUser) => existingUser != null
            ? Stream.value(existingUser)
            : apiService.registerUser(user).asStream())
        .listen((data) {
      log("successful registration");
      BaseViewModel.analytics.logSignUp(signUpMethod: "cellphone");

      storage!.mobileNumber = mobileNumber;
      storage!.profileRole = data.role;
      log("user Id is ${data.id}");
      storage!.saveIjudiUserId(data.id);
      notificationService!.updateDeviceUser(data.id!);

      Navigator.pop(context);
    }, onError: (e) {
      showError(error: e);
      BaseViewModel.analytics.logEvent(name: "error.signup", parameters: {
        "error": e.toString(),
        "cellNumber": mobileNumber
      }).then((value) => {});
    }, onDone: () {
      progressMv!.isBusy = false;
    });
  }

  bool get allFieldsValid {
    passwordValid = password != null &&
        password!.isNotEmpty &&
        (hasUkheshe || passwordConfirm == password);
    mobileNumberValid = mobileNumber.isNotEmpty &&
        Utils.validSANumber(mobileNumber);
    nameValid = name.isNotEmpty && name.length > 3;
    lastNameValid =
        lastname.isNotEmpty && lastname.length > 3;
    idNumberValid = idNumber.length == 13;
    notifyChanged();
    return mobileNumberValid && nameValid && lastNameValid;
  }
}
