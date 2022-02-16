import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/franchise-shops-view.dart';
import 'package:ijudi/view/start-shopping.dart';

class ShopComponent extends StatelessWidget with MessageDialogs {
  final Shop shop;
  final hasMoreStores;

  ShopComponent({required this.shop, this.hasMoreStores = false});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (hasMoreStores) {
          var newList = List.of(shop.franchises!)..add(shop);
          Navigator.pushNamed(context, FranchiseShopsView.ROUTE_NAME,
              arguments: newList);
        } else {
          Navigator.pushNamed(context, StartShoppingView.ROUTE_NAME,
              arguments: shop);
        }
      },
      child: Container(
          child: IJudiCard(
        width: deviceWidth >= 360 ? 157 : 127,
        child: Banner(
            message: shop.stockList.isEmpty ? "In Store" : "Delivers",
            location: BannerLocation.topStart,
            color: shop.stockList.isEmpty
                ? IjudiColors.color2
                : IjudiColors.color1,
            child: Column(
              children: <Widget>[
                Container(
                  width: deviceWidth >= 360 ? 187 : 157,
                  height: deviceWidth >= 360 ? 115 : 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    image: DecorationImage(
                      image: NetworkImage(shop.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                    width: deviceWidth >= 360 ? 187 : 157,
                    // padding: EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                                hasMoreStores
                                    ? shop.franchiseName!
                                    : shop.name!,
                                style: IjudiStyles.CARD_SHOP_HEADER2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, bottom: 4),
                            child: Text(
                              shop.description!,
                              style: IjudiStyles.CARD_SHOP_DISCR2,
                              maxLines: 2,
                              softWrap: true,
                            ))
                      ],
                    ))
              ],
            )),
      )),
    );
  }
}

class ShopCard extends StatelessWidget {
  final Widget? child;
  final double width;
  final Color? color;
  final double? elevation;

  ShopCard({this.child, this.width = 352, this.color, this.elevation});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = deviceWidth >= 360 ? 140 : 120;

    return Card(
      color: color,
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(width: width, height: null, child: child),
    );
  }
}
