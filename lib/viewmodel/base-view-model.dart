import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-error-response.dart';
import 'package:ijudi/viewmodel/progress-view-model.dart';

abstract class BaseViewModel extends State {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  ProgressViewModel? progressMv;
  bool _hasError = false;
  bool _showLogin = false;
  String _errorMessage = "";
  late Function buildFunction;
  late Function errorBuildFunction;
  late Function initWidgetFunction;
  late Function loginBuildFunction;

  String? password;
  String? username;

  BaseViewModel();

  bool get showLogin => _showLogin;
  set showLogin(bool showLogin) {
    _showLogin = showLogin;
    notifyChanged();
  }

  String get errorMessege => _errorMessage;
  set errorMessege(String errorMessage) {
    _errorMessage = errorMessage;
    notifyChanged();
  }

  bool get hasError => _hasError;
  set hasError(bool hasError) {
    _hasError = hasError;
    notifyChanged();
  }

  @protected
  @override
  Widget build(BuildContext context) {
    if (hasError) {
      Future.delayed(Duration(milliseconds: 500))
          .then((value) => errorBuildFunction(context, errorMessege));
      _hasError = false;
    } else if (showLogin) {
      Future.delayed(Duration(milliseconds: 500))
          .then((value) => loginBuildFunction(context));
      _showLogin = false;
    }
    return buildFunction(context);
  }

  @override
  void initState() {
    super.initState();
    initWidgetFunction();
    initialize();
    progressMv = ProgressViewModel();
  }

  @protected
  @override
  void setState(fn) {
    super.setState(fn);
  }

  void initialize() {}

  notifyChanged() => setState(() {});

  void showError({dynamic error}) {
    log(error.toString());
    var errorCode;
    if (error is ApiErrorResponse) {
      errorMessege = error.message.toString();
    } else {
      errorMessege = error.toString();
    }

    if (errorCode == "IAE001") {
      showLogin = true;
    } else {
      hasError = true;
    }
  }

  login() {
  }
}
