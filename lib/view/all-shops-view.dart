import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/ads-card-component.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/featured-shop.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/choose-location-view.dart';
import 'package:ijudi/viewmodel/all-shops-view-model.dart';

import '../config.dart';

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

    if (viewModel.shops != null && viewModel.shops.isNotEmpty) {
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
            name: filterName,
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
    viewModel.ads.forEach((ad) => adsComponets.add(AdsCardComponent(
        advert: ad,
        color: IjudiColors.color3,
        shop: viewModel.shops
            ?.firstWhere((item) => item.id == ad.shopId, orElse: () => null))));

    viewModel.featuredShops
        .where((shop) =>
            (viewModel.search.isEmpty ||
                shop.containsStockItem(viewModel.search) ||
                shop.name.toLowerCase().contains(viewModel.search)) &&
            (viewModel.filters.isEmpty ||
                viewModel.filters.intersection(shop.tags).length > 0))
        .forEach((shop) {
      featuredShopComponents.add(
          FeaturedShop(shop: shop, isLoggedIn: () => viewModel.isLoggedIn));
    });

    viewModel.shops
        ?.where((shop) =>
            (viewModel.search.isEmpty || shop.containsStockItem(viewModel.search) || shop.name.toLowerCase().contains(viewModel.search)) &&
            (viewModel.filters.isEmpty || viewModel.filters.intersection(shop.tags).length > 0) &&
            shop.tags.contains("restaurant")
        )
        ?.forEach((shop) {
      shopComponets.add(ShopComponent(
        shop: shop,
        isLoggedIn: () => viewModel.isLoggedIn,
      ));
    });

    var groceries = viewModel.shops
        ?.where((shop) =>
            (viewModel.search.isEmpty ||
                shop.containsStockItem(viewModel.search) ||
                shop.name.toLowerCase().contains(viewModel.search)) &&
            (shop.tags.contains("groceries")))
        ?.map((shop) => ShopComponent(
              shop: shop,
              isLoggedIn: () => viewModel.isLoggedIn,
            ))
        ?.toList();

    var medicine = viewModel.shops
        ?.where((shop) =>
            (viewModel.search.isEmpty ||
                shop.containsStockItem(viewModel.search) ||
                shop.name.toLowerCase().contains(viewModel.search)) &&
            (shop.tags.contains("medicine")))
        ?.map((shop) => ShopComponent(
              shop: shop,
              isLoggedIn: () => viewModel.isLoggedIn,
            ))
        ?.toList();

    if (viewModel.showNoShopsAvailable) {
      Future.delayed(Duration(seconds: 1), () {
        showMessageDialog(context,
            title: "iZinga is not in your area yet",
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                    "Izinga is not available in your area yet. Please subscribe and mention your favourite shop")),
            actionName: "Subscribe",
            action: () => Utils.launchURLInCustomeTab(context,
                url: "https://www.izinga.co.za#features"));
      });
    }

    return ScrollableParent(
        hasDrawer: true,
        title: "Shops",
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 4, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    viewModel.search.isNotEmpty ||
                            adsComponets.length == 0 ||
                            adsComponets.isEmpty
                        ? Container()
                        : Text("Promotions", style: IjudiStyles.HEADER_2),
                    BreadCrumb(
                        color: IjudiColors.color4,
                        name: viewModel.supportedLocation.name + " + 10km",
                        lowerCase: false,
                        onPressed: (name) {
                          Navigator.pushNamed(
                              context, ChooseLocationView.ROUTE_NAME);
                        })
                  ],
                )),
            viewModel.search.isNotEmpty ||
                    adsComponets.length == 0 ||
                    adsComponets.isEmpty
                ? Container()
                : Container(
                    child: CarouselSlider(
                        items: adsComponets,
                        options: CarouselOptions(
                          aspectRatio: 4 / 3,
                          viewportFraction: 0.56,
                          height: MediaQuery.of(context).size.height * 0.27,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          reverse: false,
                          autoPlayInterval: Duration(seconds: 10),
                          autoPlayAnimationDuration: Duration(seconds: 2),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          disableCenter: true,
                          scrollDirection: Axis.horizontal,
                        ))),
            Padding(padding: EdgeInsets.only(top: 0, bottom: 8)),
            Forms.searchField(context,
                hint: "shop name, burger, usu",
                onChanged: (value) => viewModel.search = value),
            Container(
                height: 35,
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: filterComponents)),
            featuredShopComponents.isEmpty
                ? Container()
                : Container(
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
                    child: Text("Restaurants", style: IjudiStyles.HEADER_2),
                  ),
            shopComponets.isEmpty
                ? Container()
                : Container(
                    height: deviceWidth >= 360 ? 202 : 172,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: shopComponets)),
             groceries == null  || groceries.isEmpty
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 16, top: 32, bottom: 8),
                    child: Text("Groceries", style: IjudiStyles.HEADER_2),
                  ),
            groceries == null || groceries.isEmpty
                ? Container()
                : Container(
                    height: deviceWidth >= 360 ? 202 : 172,
                    child: ListView(
                        scrollDirection: Axis.horizontal, children: groceries)),
             medicine == null || medicine.isEmpty
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 16, top: 32, bottom: 8),
                    child: Text("Medicine", style: IjudiStyles.HEADER_2)),
             medicine == null || medicine.isEmpty
                ? Container()
                : Container(
                    height: deviceWidth >= 360 ? 202 : 172,
                    margin: EdgeInsets.only(bottom: 32),
                    child: ListView(
                        scrollDirection: Axis.horizontal, children: medicine)),
          ],
        ));
  }
}
