import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';

import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class LoginViewModel extends BaseViewModel {
  
  final StorageManager storage;
  final UkhesheService ukhesheService;
  final ApiService apiService;
  
  String username;
  String password;
  List<Shop> shops;
  List<Advert> ads;

  LoginViewModel({@required this.ukhesheService,@required this.storage,
   @required this.apiService});

  login() {
    progressMv.isBusy = true;      
    var subscr = 
      ukhesheService.authenticate(username, password)
        .asStream()
        .asyncExpand((res) => apiService.findUserByPhone(username).asStream())
        .listen((data) {
      progressMv.isBusy = false;
        hasError = false;
        storage.mobileNumber = username;
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
}
