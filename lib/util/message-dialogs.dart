import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

mixin MessageDialogs {
  void showMessageDialog(BuildContext context,
      {String? title,
      Widget? child,
      String? actionName,
      Function? action,
      Function? cancel}) {
    if (cancel == null) cancel = () => {};

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(left: 0, top: 0),
                titlePadding: EdgeInsets.only(left: 16, top: 16),
                buttonPadding: EdgeInsets.only(top: 8, bottom: 16, right: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Text(title!),
                content: child,
                actions: <Widget>[
                  TextButton(
                    child: Text("Cancel", style: Forms.INPUT_TEXT_STYLE),
                    onPressed: () {
                      cancel!();
                      Navigator.of(context).pop();
                    },
                  ),
                  action is Function
                      ? TextButton(
                          child:
                              Text(actionName!, style: Forms.INPUT_TEXT_STYLE),
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
        });
  }

  void showWebViewDialog(BuildContext context,
      {Widget? header, String? url, Function? doneAction}) {
    print(url);
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String newUrl) {
            if (newUrl.startsWith("https://www.izinga.co.za")) {
              var status = Uri.parse(newUrl).pathSegments[0];
              print("status is $status");
              Navigator.of(context).pop();
              doneAction!(status);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(url!));

    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: IjudiColors.color3,
            insetPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  header != null ? header : Container(),
                  Expanded(
                      child: WebViewWidget(
                          controller: controller,
                      )
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: TextButton(
                        child: Text(
                          "Close",
                          style: IjudiStyles.CONTENT_TEXT,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          doneAction!();
                        },
                      ))
                ],
              ),
            ));
      },
    );
  }

  showLoginMessage(BuildContext context,
      {Object? params, void Function()? onLogin}) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;
    var style = isLight ? IjudiStyles.DIALOG_DARK : IjudiStyles.DIALOG_WHITE;
    showMessageDialog(context,
        title: "Login/Register Required", actionName: "Continue", action: () {
      if (onLogin != null) {
        onLogin();
      }
      Navigator.pushNamed(context, RegisterView.ROUTE_NAME, arguments: params);
    },
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                      "To get unlimited access and great benefits of your iZinga, you will need to Login or register. Please click continue to proceed.",
                      style: style))
            ]));
  }
}
