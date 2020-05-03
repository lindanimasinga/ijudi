import 'package:flutter/material.dart';
import 'package:ijudi/components/busket-view-only-component.dart';
import 'package:ijudi/components/order-component.dart';
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
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: 8,),
                      child: Text("${order.busket.shop.name}", style: IjudiStyles.HEADER_TEXT)
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: 8,),
                      child: Text("Order: ${order.id}", style: IjudiStyles.HEADER_TEXT)
                  ),
                  OrderComponent(order: order),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: 8,top: 8),
                      child: Text("Payment Details", style: IjudiStyles.HEADER_TEXT)
                  ),
                  FloatingActionButton(
                      onPressed: () => null,
                      child: Icon(Icons.check),
                    )
                ]
            )
          )
          
        ]));
  }
}
