import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/quick-pay.dart';
import 'package:ijudi/view/start-shopping.dart';

class ShopComponent extends StatefulWidget {
  final Shop shop;

  ShopComponent({this.shop});

  @override
  _ShopComponentState createState() => _ShopComponentState(shop: shop);
}

class _ShopComponentState extends State<ShopComponent> {
  Shop shop;

  _ShopComponentState({@required this.shop});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = deviceWidth > 360 ? 140 : 120;

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
            child: IJudiCard(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
              Row(
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
            ]))),
        secondaryActions: <Widget>[
          Container(
            margin: EdgeInsets.all(2),
          child: IconSlideAction(
            caption: 'Pay',
            color: IjudiColors.color2,
            icon: Icons.attach_money,
            onTap: () => {
              Navigator.pushNamed(context, QuickPayView.ROUTE_NAME, arguments: shop)
            },
          )),
        ]);
    ;
  }
}

class IJudiCard extends StatelessWidget {
  final Widget child;
  final double width;
  final Color color;
  final double elevation;

  IJudiCard({this.child, this.width = 352, this.color, this.elevation});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = deviceWidth > 360 ? 140 : 120;

    return Card(
      color: color,
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(width: width, height: null, child: child),
    );
  }
}
