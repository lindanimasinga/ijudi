import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class MvStatefulWidget<T extends BaseViewModel> extends StatefulWidget {

  final T viewModel;

  MvStatefulWidget(T viewModel) : this.viewModel = viewModel
  {
    this.viewModel.buildFunction = build;
    this.viewModel.initWidgetFunction = initialize;
    this.viewModel.errorBuildFunction = showErrorDialog;
  }

  @override
  T createState() => viewModel;

  Widget build(BuildContext context);

  void initialize(){
  }

  void showMessageDialog(BuildContext context, {
      String title, Widget child, String actionName, Function action}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 0, top: 16),
          titlePadding: EdgeInsets.only(left: 16, top: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
           ),
          title: Text(title),
          content: child,
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel", style: Forms.INPUT_TEXT_STYLE),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(actionName, style: Forms.INPUT_TEXT_STYLE),
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

  void showWebViewDialog(BuildContext context, {
      Widget header, String url, Function doneAction}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 0, top: 16),
          titlePadding: EdgeInsets.only(left: 16, top: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
           ),
          title: header,
          content: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                doneAction();
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 16, top: 16, right: 16),
          titlePadding: EdgeInsets.only(left: 16, top: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
           ),
          title: Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
             FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text("Close", style: Forms.INPUT_TEXT_STYLE),
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
