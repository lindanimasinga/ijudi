import 'package:flutter/material.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

abstract class MvStatefulWidget<T extends BaseViewModel> extends StatefulWidget {

  final T viewModel;

  MvStatefulWidget(T viewModel) : this.viewModel = viewModel
  {
    this.viewModel.buildFunction = build;
  }

  @override
  T createState() => viewModel;

  Widget build(BuildContext context);

}
