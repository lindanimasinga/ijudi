import 'package:flutter/material.dart';
import 'package:ijudi/components/basket-component.dart';
import 'package:ijudi/components/basket-view-only-component.dart';
import 'package:ijudi/components/order-review-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:intl/intl.dart';

class QuickPaymentSuccess extends StatelessWidget {
  final Order order;
  static const String ROUTE_NAME = "quick-pay-success";

  const QuickPaymentSuccess({this.order});

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        title: "Receipt",
        appBarColor: IjudiColors.color1,
        child: Stack(children: <Widget>[
          Headers.getHeader(context),
          Container(
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.topCenter,
              child: IJudiCard(
                  child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(61),
                            color: Colors.white,
                            border: Border.all(
                              color: IjudiColors.color1,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(order.shop.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          )),
                          Text("Tax Invoice  #${order.id}", style: IjudiStyles.CARD_SHOP_DISCR,),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${order.shop.name}", style: IjudiStyles.CARD_SHOP_HEADER),
                        Text("Date: ${DateFormat("dd MMM yy 'at' HH:mm").format(order.date)}", style: IjudiStyles.CARD_SHOP_DISCR,)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8)),
                    Text("*In store purchace", style: IjudiStyles.CARD_SHOP_DISCR,),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    OrderReviewComponent(order: order),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Text("Contact:  ${order.shop.mobileNumber}", style: IjudiStyles.CARD_SHOP_DISCR,),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                     Text("Thank you for your support", style: IjudiStyles.CARD_SHOP_DISCR,),

                  ],
                ),
              )))
        ]));
  }
}
