import 'package:flutter/material.dart';
import 'package:ijudi/components/ads-card-component.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/all-shops-view-model.dart';

class AllShopsView extends MvStatefulWidget<AllShopsViewModel> {

  static const ROUTE_NAME = "shopping";

  AllShopsView({AllShopsViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {

    List<ShopComponent> shopComponets = [];
    viewModel.shops.forEach((shop) => shopComponets.add(ShopComponent(shop: shop)));

    List<AdsCardComponent> adsComponets = [];
    viewModel.ads.forEach((ad) => adsComponets
            .add(AdsCardComponent(
                advert: ad, 
                color: IjudiColors.color3)
            )
          );

    return ScrollableParent(
      hasDrawer: true,
      title: "Shops",
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:16, top: 8, bottom: 8),
            child: Text("Featured", style: Forms.INPUT_TEXT_STYLE,),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: adsComponets
            )
          ),
          Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
          Forms.searchField(context, "shop name, burger, usu"),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text("Shops", style: Forms.INPUT_TEXT_STYLE,),
          ),
          Column(
            children: shopComponets
          )
        ],
      ));
  }
}