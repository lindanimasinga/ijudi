import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/viewmodel/progress-view-model.dart';

abstract class BaseViewModel extends State {

  ProgressViewModel progressMv;
  bool _hasError = false;
  String _errorMessage = "";
  Function buildFunction;
  Function initFunction;

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
    return buildFunction(context);
  }

  @override
  void initState() {
    super.initState();
    initFunction();
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

  get currentUser => ApiService.findUserById("s");

}