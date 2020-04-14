import 'package:flutter/material.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/theme-utils.dart';

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
    return Cards.shop(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 157,
                height: 118,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: new NetworkImage(shop.imageUrl),
                  )
                ),
      ),
              Container(
                  width: 148,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(shop.name, style: IjudiStyles.CARD_SHOP_HEADER),
                      Padding(padding: EdgeInsets.all(4)),
                      Text(
                        shop.description,
                        style: IjudiStyles.CARD_SHOP_DISCR,
                        maxLines: 2,
                        softWrap: true,
                      ),
                      Padding(padding: EdgeInsets.only(top: 28)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {},
                            child: Text("Shop Now")
                          )
                        ]
                      )
                    ],
                  ))
            ],
          ),
          
        ]));
  }
}
