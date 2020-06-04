import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:intl/intl.dart';

class OrderHistoryItemComponent extends StatelessWidget {
  
  static const statusColors = [IjudiColors.color2, 
            IjudiColors.color3, IjudiColors.color4, IjudiColors.color1];
  static const statusText = ["Processing", 
            "Scheduled", "Arriving", "Delivered"];          
  final Order order;

  OrderHistoryItemComponent({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: IJudiCard(
        child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Order Number: ${order.id}", style: IjudiStyles.CARD_SHOP_DISCR),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text("Ordered On: ${DateFormat("dd MMM yy 'at' HH:mm").format(order.date)}", style: IjudiStyles.CARD_SHOP_DISCR),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text("Total Amount: R${order.totalAmount}")
                    ],
                  )
                ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                    FinalOrderView.ROUTE_NAME,
                      (Route<dynamic> route) => false, arguments: order);
                }, 
                child: Container(
                  alignment: Alignment.center,
                  width: 90,
                  height: 100,
                  decoration: BoxDecoration(
                    color: statusColors[order.stage],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)),
                  ),
                  child: Text(statusText[order.stage], style: IjudiStyles.HEADER_TEXT,),
                )
              )
            ]
            )
          ),
      ),
    );
  }
}
