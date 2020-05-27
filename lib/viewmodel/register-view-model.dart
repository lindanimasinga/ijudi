import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class RegisterViewModel extends BaseViewModel {
  
  final UkhesheService ukhesheService;
  final ApiService apiService;
  String otp;
  final String _aboutUkheshe = "Ukheshe is a digital wallet that lets you buy goods and received money without a need to have a"+ 
                      "bank account.\n\nIt simple requires only your mobile number and you are good to go." +
                      "You can send, receive and withdraw and deposit money from any ATM or Pick n Pay stores";

  
  RegisterViewModel({this.ukhesheService, @required this.apiService});
  
  String idNumber = "";
  String name = "";
  String lastname = "";
  String description = "";
  int yearsInService = 0;
  String email;
  String address = "";
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

  bool get hasUkheshe => _hasUkheshe;
  set hasUkheshe(bool hasUkheshe) {
    _hasUkheshe = hasUkheshe;
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


  _registerBank() {
    _bank.name = name;
    _bank.phone = mobileNumber;
    _bank.type = "wallet";
    progressMv.isBusy = true;
  ukhesheService.registerUkhesheAccount(_bank, otp, password).asStream().listen(
      (event) {
        Navigator.pushNamedAndRemoveUntil(
              context, LoginView.ROUTE_NAME, (Route<dynamic> route) => false);
      }, 
      onDone: () {
        progressMv.isBusy = false;
      });
  }

  registerUser() {
    
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
        role: "customer",
        bank: _bank);
        
    progressMv.isBusy = true;
    apiService.registerUser(user)
      .asStream()
      .listen(
        (event) {
          print("successful registration");
          if(!hasUkheshe) {
          _registerBank();
          return;
          }
          Navigator.pushNamedAndRemoveUntil(
                context, LoginView.ROUTE_NAME, (Route<dynamic> route) => false);
        }, 
        onDone: () {
            progressMv.isBusy = false;
        });
  }

  _registerUserOtpRequest() {
    progressMv.isBusy = true;
    ukhesheService.requestOpt(mobileNumber)
      .asStream()
      .listen((event) {
      },
      onDone: () => progressMv.isBusy = false);
  }

  void startRegistration() {
        _registerUserOtpRequest();
  }
    
  bool get allFieldsValid {
    return password != null && passwordConfirm == password && 
      mobileNumber != null && mobileNumber.length == 10;
  }
}