import 'package:flutter/material.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';

class PaymentView extends StatefulWidget {
  
  final Order order;
  static const String ROUTE_NAME = "payment";

  PaymentView({@required this.order});

  @override
  _StatePaymentView createState() => _StatePaymentView(this.order);
}

class _StatePaymentView extends State<PaymentView> {
  
  Order order;

  _StatePaymentView(this.order);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color3,
        title: "Payment",
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          
        ]));
  }
}
