import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class RegisterViewModel extends BaseViewModel {
  final UkhesheService ukhesheService;
  final ApiService apiService;
  String otp;
  final String _aboutUkheshe =
      "Ukheshe is a digital wallet that lets you buy goods and received money without a need to have a" +
          "bank account.\n\nIt simple requires only your mobile number and you are good to go." +
          "You can send, receive and withdraw and deposit money from any ATM or Pick n Pay stores.\n\nBy signing up, I agree to the terms and conditions below.";

  bool passwordValid = true;
  bool mobileNumberValid = true;
  bool nameValid = true;
  bool lastNameValid = true;
  var idNumberValid = true;
  ProfileRoles _interests = ProfileRoles.CUSTOMER;
    String idNumber = "";
  String name = "";
  String lastname = "";
  String description = "";
  int yearsInService = 0;
  String email;
  String _address = "";
  String imageUrl = "https://pbs.twimg.com/media/C1OKE9QXgAAArDp.jpg";
  int likes = 0;
  int servicesCompleted = 0;
  int badges = 0;
  String mobileNumber = "";
  String role = "";
  int responseTimeMinutes = 0;
  String password;
  String passwordConfirm;
  bool _hasUkheshe = false;

  RegisterViewModel({this.ukhesheService, @required this.apiService});

  bool get hasUkheshe => _hasUkheshe;
  set hasUkheshe(bool hasUkheshe) {
    _hasUkheshe = hasUkheshe;
    notifyChanged();
  }

  String get address => _address;
  set address(String address) {
    _address = address;
    notifyChanged();
  }

    ProfileRoles get interests => _interests;

  set interests(ProfileRoles interests) {
    _interests = interests;
    notifyChanged();
  }

  String bankName;
  String bankAccountNumber;
  String bankAccountType;
  String bankCellNumber;
  Bank _bank = Bank(name: null, accountId: null, type: null);

  String get ukhesheMessage => hasUkheshe
      ? "Your Ijudi account will be linked to your Ukheshe account. " +
          "You will be able to top up, buy goods and receive money using your ukheshe account with ijudi."
      : "Registering with Ijudi will automatically create you an Ukheshe account. " +
          _aboutUkheshe;

  Stream _registerBank() {
    _bank.name = name;
    _bank.phone = mobileNumber;
    _bank.type = "wallet";
    if (otp == null || otp.isEmpty) {
      Stream.error("Please try again and enter otp received via SMS.");
    }
    return ukhesheService
        .registerUkhesheAccount(_bank, otp, password)
        .asStream();
  }

  registerUser() {
    if (!allFieldsValid) return;

    _bank.name = "Ukheshe";
    _bank.phone = mobileNumber;
    _bank.type = "wallet";

    var user = UserProfile(
        id: idNumber,
        name: name,
        idNumber: idNumber,
        description: "customer",
        imageUrl: imageUrl,
        mobileNumber: mobileNumber,
        address: address,
        role: ProfileRoles.CUSTOMER,
        bank: _bank);

    progressMv.isBusy = true;
    Stream stream = !hasUkheshe ? _registerBank() : Stream.value(0);
    stream
        .asyncExpand((event) => apiService.registerUser(user).asStream())
        .listen((event) {
      print("successful registration");
      BaseViewModel.analytics.logSignUp(signUpMethod: "cellphone");
      Navigator.pushNamedAndRemoveUntil(
          context, LoginView.ROUTE_NAME, (Route<dynamic> route) => false);
    }, onError: (e) {
      showError(error: e);

      BaseViewModel.analytics.logEvent(name: "signup-error", parameters: {
        "error": e.toString(),
        "cellNumber": mobileNumber
      }).then((value) => {});
    }, onDone: () {
      progressMv.isBusy = false;
    });
  }

  _registerUserOtpRequest() {
    progressMv.isBusy = true;
    ukhesheService.requestOpt(mobileNumber).asStream().listen((event) {},
        onError: (e) {
          showError(error: e);
        },
        onDone: () => progressMv.isBusy = false);
  }

  void startRegistration() {
    _registerUserOtpRequest();
  }

  bool get allFieldsValid {
    passwordValid = password != null &&
        password.isNotEmpty &&
        (hasUkheshe || passwordConfirm == password);
    mobileNumberValid = mobileNumber != null &&
        mobileNumber.isNotEmpty &&
        Utils.validSANumber(mobileNumber);
    nameValid = name != null && name.isNotEmpty && name.length > 3;
    lastNameValid =
        lastname != null && lastname.isNotEmpty && lastname.length > 3;
    notifyChanged();
    return passwordValid && mobileNumberValid && nameValid && lastNameValid;
  }
}
