import 'package:flutter/material.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class ProgressViewModel extends BaseViewModel with SingleTickerProviderStateMixin {

  var _isBusy = false;
  var colorTween;
  AnimationController controller;

  get isBusy => _isBusy;
  set isBusy(isBusy) {
    _isBusy = isBusy;
    notifyChanged();
  }

  @override
  void initialize() {
    controller = AnimationController(
      duration: Duration(milliseconds: 1800),
      vsync: this
    );

    colorTween = controller
        .drive(ColorTween(begin: Colors.white, end: Colors.white));
    super.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}