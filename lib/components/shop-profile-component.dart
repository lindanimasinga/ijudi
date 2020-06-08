import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/shop-profile-view.dart';
import 'package:ijudi/view/start-shopping.dart';

import 'ijudi-card.dart';

class ShopProfileComponent extends StatelessWidget {
  
  final Shop shop;

  ShopProfileComponent({this.shop});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = deviceWidth > 360 ? 140 : 120;

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        movementDuration: Duration(milliseconds: 500),
        actionExtentRatio: 0.25,
        child: GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, ShopProfileView.ROUTE_NAME,
                arguments: shop),
            onLongPress: () {
              Navigator.pushNamed(context, StartShoppingView.ROUTE_NAME,
                  arguments: shop);
            },
            child: Container(
                child: IJudiCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: deviceWidth > 360 ? 187 : 157,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0)),
                      image: DecorationImage(
                        image: NetworkImage(shop.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                      width: 148,
                      // padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(shop.name,
                              style: IjudiStyles.CARD_SHOP_HEADER,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          Padding(padding: EdgeInsets.all(4)),
                          Text(
                            shop.description,
                            style: IjudiStyles.CARD_SHOP_DISCR,
                            maxLines: 2,
                            softWrap: true,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: deviceWidth > 360 ? 18 : 8)),
                        ],
                      ))
                ],
              ),
            ))),
        secondaryActions: <Widget>[
          Container(
              margin: EdgeInsets.all(4),
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Shop",
                      style: IjudiStyles.HEADER_TEXT,
                    )
                  ],
                ),
                color: IjudiColors.color2,
                onPressed: () => Navigator.pushNamed(
                    context, StartShoppingView.ROUTE_NAME,
                    arguments: shop),
              )),
        ]);
    ;
  }
}