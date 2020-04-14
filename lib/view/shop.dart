import 'package:flutter/material.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/util/theme-utils.dart';

class ShoppingView extends StatefulWidget {

  static const ROUTE_NAME = "shopping";

  @override
  _ShoppingViewState createState() => _ShoppingViewState();

}


class _ShoppingViewState extends State<ShoppingView> {

  
  @override
  Widget build(BuildContext context) {
    return JudiTheme.buildFromParent(
      title: "Shops",
      child: Column(
        children: <Widget>[
          Container(
            height: 316,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Cards.createAd(
                  color: IjudiColors.color2,
                  child: Container()
                ),
                Cards.createAd(
                  color: IjudiColors.color3,
                  child: Container()
                )
              ]
            )
          ),
          Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
          Forms.searchField(context, "store name, bread, suger"),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text("Shops", style: Forms.INPUT_TEXT_STYLE,),
          ),
          ShopComponent(),
          ShopComponent(),
          ShopComponent(),
          ShopComponent(),
          ShopComponent()
        ],
      ));
  }
}