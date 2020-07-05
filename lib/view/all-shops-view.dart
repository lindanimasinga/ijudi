import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ijudi/components/ads-card-component.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/featured-shop.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
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

    if (viewModel.shops.isNotEmpty) {
      var tags =
          viewModel.shops.map((shop) => shop.tags).reduce((current, next) {
        Set<String> tagsSet = HashSet();
        tagsSet.addAll(current);
        tagsSet.addAll(next);
        return tagsSet;
      }).toList();

      tags.sort();
      for (var filterName in tags) {
        var color = BreadCrumb.statusColors[colorPickCount++];
        filterComponents.add(BreadCrumb(
            color: color,
            filterName: filterName,
            selected: viewModel.filters.contains(filterName),
            onPressed: (name) {
              if (viewModel.filters.contains(name)) {
                viewModel.removeFilter(name);
              } else {
                viewModel.addFilter(name);
              }
            }));
        if (colorPickCount > 3) colorPickCount = 0;
      }
    }

    List<AdsCardComponent> adsComponets = [];
    viewModel.ads.forEach((ad) => adsComponets
        .add(AdsCardComponent(advert: ad, color: IjudiColors.color3)));

    viewModel.featuredShops
        .where((shop) =>
            (viewModel.search.isEmpty ||
                shop.containsStockItem(viewModel.search) ||
                shop.name.toLowerCase().contains(viewModel.search)) &&
            (viewModel.filters.isEmpty ||
                viewModel.filters.intersection(shop.tags).length > 0))
        .forEach((shop) {
      featuredShopComponents.add(FeaturedShop(shop: shop));
    });

    viewModel.shops
        .where((shop) =>
            (viewModel.search.isEmpty ||
                shop.containsStockItem(viewModel.search) ||
                shop.name.toLowerCase().contains(viewModel.search)) &&
            (viewModel.filters.isEmpty ||
                viewModel.filters.intersection(shop.tags).length > 0))
        .forEach((shop) {
      shopComponets.add(ShopComponent(shop: shop));
    });

    return ScrollableParent(
        hasDrawer: true,
        title: "Shops",
        child: Column(
          children: <Widget>[
            adsComponets.length == 0
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    padding:
                        EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
                    child: viewModel.search.isNotEmpty ||
                            adsComponets.length == 0
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Promotions", style: IjudiStyles.HEADER_2),
                              DropdownButton<String>(
                                value: viewModel.radiusText,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: IjudiStyles.SUBTITLE_2,
                                underline: Container(
                                  height: 2,
                                  color: IjudiColors.color5,
                                ),
                                onChanged: (String newValue) =>
                                    viewModel.radiusText = newValue,
                                items: Utils.rangeMap.keys
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                              )
                            ],
                          )),
            viewModel.search.isNotEmpty || adsComponets.length == 0
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: adsComponets)),
            Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
            Forms.searchField(context,
                hint: "shop name, burger, usu",
                onChanged: (value) => viewModel.search = value),
            Container(
                height: 35,
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: filterComponents)),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: Text("Featured", style: IjudiStyles.HEADER_2),
            ),
            Column(children: featuredShopComponents),
            shopComponets.isEmpty
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 16, top: 32, bottom: 8),
                    child: Text("Shops", style: IjudiStyles.HEADER_2),
                  ),
            Container(
                height: deviceWidth >= 360 ? 202 : 172,
                margin: EdgeInsets.only(bottom: 32),
                child: ListView(
                    scrollDirection: Axis.horizontal, children: shopComponets)),
          ],
        ));
  }
}
