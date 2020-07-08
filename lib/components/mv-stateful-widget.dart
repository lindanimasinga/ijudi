import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class MvStatefulWidget<T extends BaseViewModel>
    extends StatefulWidget {
  final T viewModel;

  MvStatefulWidget(T viewModel) : this.viewModel = viewModel {
    this.viewModel.buildFunction = build;
    this.viewModel.initWidgetFunction = initialize;
    this.viewModel.errorBuildFunction = showErrorDialog;
  }

  @override
  T createState() => viewModel;

  Widget build(BuildContext context);

  void initialize() {}

  void showMessageDialog(BuildContext context,
      {String title,
      Widget child,
      String actionName,
      Function action,
      Function cancel}) {
    if (cancel == null) cancel = () => {};

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
                cancel();
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

  void showWebViewDialog(BuildContext context,
      {Widget header, String url, Function doneAction}) {
    print(url);
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              height:  Utils.calculationDialogMinHeight(context),
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  header,
                  Expanded(
                      child: WebView(
                          initialUrl: url,
                          onPageFinished: (url) {
                            if (url == "http:/localhost") {}
                          },
                          javascriptMode: JavascriptMode.unrestricted)),
                  Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          doneAction();
                        },
                      ))
                ],
              ),
            ));
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
