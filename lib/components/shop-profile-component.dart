import 'package:flutter/material.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/my-shop-orders.dart';
import 'package:ijudi/view/shop-profile-view.dart';
import 'package:ijudi/view/stock-view.dart';

import 'ijudi-card.dart';

class ShopProfileComponent extends StatelessWidget {
  final Shop? shop;

  ShopProfileComponent({this.shop});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = deviceWidth >= 360 ? 140 : 120;

    return Container(
                child: IJudiCard(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: deviceWidth >= 360 ? 167 : 128,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0)),
                        image: DecorationImage(
                          image: NetworkImage(shop!.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                    Container(
                        width: deviceWidth >= 360 ? 176 : 176,
                        padding: EdgeInsets.only(left: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(shop!.name!,
                                style: IjudiStyles.CARD_SHOP_HEADER,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Padding(padding: EdgeInsets.all(4)),
                            Text(
                              shop!.description!,
                              style: IjudiStyles.CARD_SHOP_DISCR,
                              maxLines: 2,
                              softWrap: true,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: deviceWidth >= 360 ? 18 : 8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        iconSize: 32,
                                        icon: Icon(Icons.info,
                                            color: IjudiColors.color1),
                                        onPressed: () => Navigator.pushNamed(
                                            context,
                                            ShopProfileView.ROUTE_NAME,
                                            arguments: shop)),
                                    Text("Shop Info",
                                        style: IjudiStyles.CARD_ICON_BUTTON)
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(left: 4)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        iconSize: 24,
                                        icon: Icon(Icons.storage,
                                            color: IjudiColors.color4),
                                        onPressed: () => Navigator.pushNamed(
                                            context,
                                            StockManagementView.ROUTE_NAME,
                                            arguments: shop)),
                                    Text("Stock",
                                        style: IjudiStyles.CARD_ICON_BUTTON)
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(left: 4)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        iconSize: 24,
                                        icon: Icon(Icons.fastfood,
                                            color: IjudiColors.color2),
                                        onPressed: () => Navigator.pushNamed(
                                            context,
                                            MyShopOrdersView.ROUTE_NAME,
                                            arguments: shop!.id)),
                                    Text("Orders",
                                        style: IjudiStyles.CARD_ICON_BUTTON)
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(left: 16))
                              ],
                            )
                          ],
                        ))
                  ],
                )
              ]),
            ));
    ;
  }
}
