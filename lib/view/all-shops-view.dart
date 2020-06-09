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
    List<FeaturedShop> featuredShopComponents = [];
    List<ShopComponent> shopComponets = [];
    List<Widget> filterComponents = [];

    if(viewModel.shops.isNotEmpty) {
      var sortedFilterNames = viewModel.shops
        .map((shop) => shop.tags)
        .reduce((current, next) { 
          Set<String> tagsSet = HashSet();
          tagsSet.addAll(current);
          tagsSet.addAll(next);
          return tagsSet;
        }).toList();

      sortedFilterNames.sort();
      for(var filterName in sortedFilterNames) {
        var color = BreadCrumb.statusColors[colorPickCount++];
          filterComponents.add(
            BreadCrumb(
              color: color,
              filterName: filterName,
              selected: viewModel.filters.contains(filterName),
              onPressed: (name) {
                if(viewModel.filters.contains(name)) {
                  viewModel.removeFilter(name);
                } else {
                  viewModel.addFilter(name);
                }
              }
            )
          );
          if(colorPickCount > 3) colorPickCount = 0;
        } 
    }

    List<AdsCardComponent> adsComponets = [];
    viewModel.ads.forEach((ad) => adsComponets
            .add(AdsCardComponent(
                advert: ad, 
                color: IjudiColors.color3)
            )
          );
    
    viewModel.featuredShops
      .where((shop) => viewModel.filters.isEmpty || viewModel.filters.intersection(shop.tags).length > 0)
      .forEach((shop) {
        featuredShopComponents.add(FeaturedShop(shop: shop));
      });

    viewModel.shops
      .where((shop) => viewModel.filters.isEmpty || viewModel.filters.intersection(shop.tags).length > 0)
      .forEach((shop) {
        shopComponets.add(ShopComponent(shop: shop));
      });  

    return ScrollableParent(
      hasDrawer: true,
      title: "Shops",
      child: Column(
        children: <Widget>[
          adsComponets.length == 0 ? Container() : Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:16, top: 8, bottom: 8),
            child: Text("Promotions", style: IjudiStyles.HEADER_2),
          ),
          adsComponets.length == 0 ? Container() : Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: adsComponets
            )
          ),
          Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
          Forms.searchField(context, hint: "shop name, burger, usu"),
          Container(
            height: 35,
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filterComponents
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text("Featured", style: IjudiStyles.HEADER_2),
          ),
          Column(
            children: featuredShopComponents
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
              children: shopComponets
            )
          ),
        ],
      ));
  }
}