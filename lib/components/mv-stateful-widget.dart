import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

abstract class MvStatefulWidget<T extends BaseViewModel> extends StatefulWidget {

  final T viewModel;

  MvStatefulWidget(T viewModel) : this.viewModel = viewModel
  {
    this.viewModel.buildFunction = build;
     this.viewModel.initFunction = initialize;
  }

  @override
  T createState() => viewModel;

  Widget build(BuildContext context);

  void initialize(){
  }

  void showMessageDialog(BuildContext context, {
      String title, Widget child, Function action}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 0, top: 16),
          titlePadding: EdgeInsets.only(left: 16, top: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: IjudiColors.color5, width: 5)),
          title: new Text("Confirm Code"),
          content: child,
          actions: <Widget>[
            new FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: new Text("Close", style: Forms.INPUT_TEXT_STYLE),
              onPressed: () {
                Navigator.of(context).pop();
                action();
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, {String errorMessage}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 0, top: 16),
          titlePadding: EdgeInsets.only(left: 16, top: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: IjudiColors.color5, width: 5)),
          title: new Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            new FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: new Text("Close", style: Forms.INPUT_TEXT_STYLE),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
