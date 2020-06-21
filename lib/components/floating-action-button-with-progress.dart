import 'package:flutter/material.dart';
import 'package:ijudi/viewmodel/progress-view-model.dart';

import 'mv-stateful-widget.dart';

class FloatingActionButtonWithProgress extends MvStatefulWidget<ProgressViewModel> {
  
  final Widget child;
  final Function onPressed;
  final color;

  FloatingActionButtonWithProgress({
   @required this.onPressed,
   @required this.child,
   @required viewModel,
   this.color
  }) : super(viewModel);

  @override
  Widget build(BuildContext context) {

    //viewModel.isBusy = false;
    //print("chnged");
    if(viewModel.isBusy) {
      viewModel.controller.repeat();
    } else {
      viewModel.controller.stop();
    }

    return viewModel.isBusy
        ? FloatingActionButton(
            onPressed: null, 
            child: CircularProgressIndicator(
              valueColor: viewModel.colorTween,
              strokeWidth: 2,
            ))
        : FloatingActionButton(
            backgroundColor: color,
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              onPressed();
            },
            child: child
          );
  }
}
