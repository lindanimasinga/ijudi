import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:webview_flutter/webview_flutter.dart';

mixin MessageDialogs {
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
          contentPadding: EdgeInsets.only(left: 0, top: 0),
          titlePadding: EdgeInsets.only(left: 16, top: 16),
          buttonPadding: EdgeInsets.only(top: 8, bottom: 16, right: 8),
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
            action is Function
                ? FlatButton(
                    child: Text(actionName, style: Forms.INPUT_TEXT_STYLE),
                    onPressed: () {
                      Navigator.of(context).pop();
                      action();
                    },
                  )
                : Container(),
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
              height: Utils.calculationDialogMinHeight(context),
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
}
