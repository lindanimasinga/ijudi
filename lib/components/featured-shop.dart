import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/start-shopping.dart';

class FeaturedShop extends StatelessWidget with MessageDialogs {
  final Shop shop;

  FeaturedShop({required this.shop});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = deviceWidth >= 360 ? 140 : 120;

    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, StartShoppingView.ROUTE_NAME,
            arguments: shop),
        child: Container(
            child: IJudiCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: deviceWidth >= 360 ? 187 : 157,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0)),
                  image: DecorationImage(
                    image: NetworkImage(shop.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                  width: deviceWidth >= 360 ? 148 : 128,
                  // padding: EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 4, top: 8),
                          child: Text(shop.name!,
                              style: IjudiStyles.CARD_SHOP_HEADER,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      Padding(
                        padding: EdgeInsets.only(right: 4, top: 8),
                        child: Text(
                          shop.description!,
                          style: IjudiStyles.CARD_SHOP_DISCR,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: deviceWidth >= 360 ? 18 : 8)),
                      Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, StartShoppingView.ROUTE_NAME,
                                  arguments: shop),
                              child: Text("Shop Now")))
                    ],
                  ))
            ],
          ),
        )));
    ;
  }
}
