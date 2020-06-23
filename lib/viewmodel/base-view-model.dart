import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/viewmodel/progress-view-model.dart';

abstract class BaseViewModel extends State {

  static final FirebaseAnalytics analytics = FirebaseAnalytics(); 

  ProgressViewModel progressMv;
  bool _hasError = false;
  String _errorMessage = "";
  Function buildFunction;
  Function errorBuildFunction;
  Function initWidgetFunction;

  String get errorMessage => _errorMessage;
  set errorMessage(String errorMessage) {
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
    if(hasError) {
      Future.delayed(Duration(milliseconds: 500))
      .then((value) => errorBuildFunction(context, errorMessage));
      _hasError = false;
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

  void initialize() {
  }

  notifyChanged() => setState(() {});

}