import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class RegisterViewModel extends BaseViewModel {
  
  final UkhesheService ukhesheService;
  String otp;

  RegisterViewModel(this.ukhesheService);
  
  String _idNumber = "";

  String get id => _idNumber;
  set id(String id) {
    _idNumber = id;
    notifyChanged();
  }

  String _name = "";

  String get name => _name;
  set name(String name) {
    _name = name;
    notifyChanged();
  }

  String _lastname = "";

  String get lastname => _lastname;
  set lastname(String lastname) {
    _lastname = lastname;
    notifyChanged();
  }

  String _description = "";

  String get description => _description;
  set description(String description) {
    _description = description;
    notifyChanged();
  }

  int _yearsInService = 0;

  int get yearsInService => _yearsInService;
  set yearsInService(int yearsInService) {
    _yearsInService = yearsInService;
    notifyChanged();
  }

  String _email;

  String get email => _email;
  set email(String email) {
    _email = email;
  }

  String _address = "";

  String get address => _address;
  set address(String address) {
    _address = address;
  }

  String _imageUrl = "";

  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  int _likes = 0;

  int get likes => _likes;
  set likes(int likes) {
    _likes = likes;
  }

  int _servicesCompleted = 0;

  int get servicesCompleted => _servicesCompleted;
  set servicesCompleted(int servicesCompleted) {
    _servicesCompleted = servicesCompleted;
    notifyChanged();
  }

  int _badges = 0;

  int get badges => _badges;
  set badges(int badges) {
    _badges = badges;
    notifyChanged();
  }

  String _mobileNumber = "";

  String get mobileNumber => _mobileNumber;
  set mobileNumber(String mobileNumber) {
    _mobileNumber = mobileNumber;
    notifyChanged();
  }

  String _role = "";

  String get role => _role;
  set role(String role) {
    _role = role;
    notifyChanged();
  }

  int _responseTimeMinutes = 0;

  int get responseTimeMinutes => _responseTimeMinutes;
  set responseTimeMinutes(int responseTimeMinutes) {
    _responseTimeMinutes = responseTimeMinutes;
    notifyChanged();
  }

  String _password;

  String get password => _password;
  set password(String password) {
    _password = password;
    notifyChanged();
  }

  String _passwordConfirm;

  String get passwordConfirm => _passwordConfirm;
  set passwordConfirm(String passwordConfirm) {
    _passwordConfirm = passwordConfirm;
    notifyChanged();
  }

  bool _hasUkheshe = false;

  bool get hasUkheshe => _hasUkheshe;
  set hasUkheshe(bool hasUkheshe) {
    _hasUkheshe = hasUkheshe;
    notifyChanged();
  }

  String _bankName;

  String get bankName => _bankName;
  set bankName(String bankName) {
    _bankName = bankName;
    notifyChanged();
  }

  String _bankAccountNumber;

  String get bankAccountNumber => _bankAccountNumber;
  set bankAccountNumber(String bankAccountNumber) {
    _bankAccountNumber = bankAccountNumber;
    notifyChanged();
  }

  String _bankAccountType;

  String get bankAccountType => _bankAccountType;
  set bankAccountType(String bankAccountType) {
    _bankAccountType = bankAccountType;
    notifyChanged();
  }

  String _bankCellNumber;

  String get bankCellNumber => _bankCellNumber;
  set bankCellNumber(String bankCellNumber) {
    _bankCellNumber = bankCellNumber;
    notifyChanged();
  }

  Bank _bank = Bank(name: null, accountId: null, type: null);

  _registerBank() {
    _bank.name = _name;
    _bank.phone = mobileNumber;
    _bank.type = "wallet";
    progressMv.isBusy = true;
  ukhesheService.registerUkhesheAccount(_bank, otp, _password).listen(
      (event) {
        notifyChanged();
      }, 
      onDone: () {
          progressMv.isBusy = false;
          Navigator.pushNamedAndRemoveUntil(
              context, LoginView.ROUTE_NAME, (Route<dynamic> route) => false);
      });
  }

  registerUser() {
    
    _bank.name = _name;
    _bank.phone = mobileNumber;
    _bank.type = "wallet";

    var user = UserProfile(
        id: _idNumber,
        name: _name,
        idNumber: _idNumber,
        description: "customer",
        imageUrl: _imageUrl,
        mobileNumber: _mobileNumber,
        role: "customer",
        bank: _bank);
        
    progressMv.isBusy = true;
    ApiService.registerUser(user)
      .listen(
        (event) {
          print("successful registration");
          _registerBank();
        }, 
        onDone: () {
            progressMv.isBusy = false;
        });
  }

  _registerUserOtpRequest() {
    progressMv.isBusy = true;
    ukhesheService.requestOpt(mobileNumber)
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
