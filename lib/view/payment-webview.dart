import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  static const String ROUTE_NAME = "/payment-webview";
  final String? url;
  final Function? doneAction;

  const PaymentWebView({this.url, this.doneAction});

  @override
  Widget build(BuildContext context) {
    //log(url!);
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: BreadCrumb.statusColors[Random().nextInt(1)],
        title: "Payment",
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  child: WebView(
                      initialUrl: url,
                      gestureNavigationEnabled: true,
                      onPageStarted: (url) {
                        if (url.startsWith("https://www.izinga.co.za")) {
                          var status = Uri.parse(url).pathSegments[0];
                          print("status is $status");
                          Navigator.of(context).pop();
                          doneAction!(status);
                        }
                      },
                      javascriptMode: JavascriptMode.unrestricted))
            ],
          ),
        ));
  }
}
