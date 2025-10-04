import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  static const ROUTE_NAME = "payment-webview";

  final String? url;
  final Function? doneAction;

  const PaymentWebView({Key? key, this.url, this.doneAction}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.url != null && widget.url!.isNotEmpty) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {
              if (url.startsWith("https://www.izinga.co.za")) {
                var status = Uri.parse(url).pathSegments[0];
                print("status is $status");
                Navigator.of(context).pop();
                if (widget.doneAction != null) {
                  widget.doneAction!(status);
                }
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: BreadCrumb.statusColors[0],
        title: "Payment",
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _controller == null
                ? Center(child: Text("Invalid payment URL."))
                : WebViewWidget(controller: _controller!)));
  }
}
