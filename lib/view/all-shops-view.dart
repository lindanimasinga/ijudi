import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ijudi/components/ads-card-component.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/featured-shop.dart';
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
    
    double deviceWidth = MediaQuery.of(context).size.width;
    var colorPickCount = 0;
    Set<FeaturedShop> featuredShops = HashSet();
    Set<ShopComponent> shopComponets = HashSet();
    Set<Widget> filters = HashSet();
    if(viewModel.shops.length > 0) {
    viewModel.shops.map((shop) {
        featuredShops.add(FeaturedShop(shop: shop));
        shopComponets.add(ShopComponent(shop: shop));
        return shop.tags;
      })
      .reduce((current, next) { 
        var list = [];
        list.addAll(next);
        list.addAll(next);
        return current;
      }).forEach((filterName) {
        var color = BreadCrumb.statusColors[colorPickCount++];
        filters.add(
          BreadCrumb(
            filterName: filterName, 
            onPressed: () => {},
            color: color,
          )
        );
        if(colorPickCount > 3) colorPickCount = 0;
      });
    }

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
            child: Text("Promotions", style: IjudiStyles.HEADER_2),
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
            height: 35,
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filters.toList()
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text("Featured", style: IjudiStyles.HEADER_2),
          ),
          Column(
            children: featuredShops.toList()
          ),
          shopComponets.isEmpty? Container() : Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 16, top: 32, bottom: 8),
            child: Text("Nearby Shops", style: IjudiStyles.HEADER_2),
          ),
          Container(
            height: deviceWidth > 360 ? 192 : 162,
            margin: EdgeInsets.only(bottom: 32),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: shopComponets.toList()
            )
          ),
        ],
      ));
  }
}