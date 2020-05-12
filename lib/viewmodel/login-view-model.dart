import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class LoginViewModel extends BaseViewModel {
  
  String _username;

  String get username => _username;
  set username(String username) {
    _username = username;
  }

  String _password;

  String get password => _password;
  set password(String password) {
    _password = password;
  }

  login() {
    progressMv.isBusy = true;
    var subscr = UkhesheService.authenticate(_username, _password).listen(null);
    subscr.onData((data) {
      progressMv.isBusy = false;
        hasError = false;
        Navigator.pushNamedAndRemoveUntil(
            context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false);
    }); 

    subscr.onError((handleError) {
      hasError = true;
      errorMessage = handleError.toString();
      progressMv.isBusy = false;
    });
  }

  register() {
    Navigator.pushNamed(context, RegisterView.ROUTE_NAME);
  }
}
