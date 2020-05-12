import 'package:flutter/material.dart';
import 'package:ijudi/viewmodel/progress-view-model.dart';

import 'mv-stateful-widget.dart';

class FloatingActionButtonWithProgress extends MvStatefulWidget<ProgressViewModel> {
  
  final Widget child;
  final Function onPressed;

  FloatingActionButtonWithProgress({
   @required this.onPressed,
   @required this.child,
   @required viewModel
  }) : super(viewModel);

  @override
  Widget build(BuildContext context) {

    if(viewModel.isBusy) {
      viewModel.controller.repeat();
    }

    return viewModel.isBusy
        ? FloatingActionButton(
            onPressed: null, 
            child: CircularProgressIndicator(
              valueColor: viewModel.colorTween,
              strokeWidth: 2,
            ))
        : FloatingActionButton(
            onPressed: () => onPressed(),
            child: child
          );
  }
}
