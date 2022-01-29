import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-profile-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/my-shops-view-model.dart';

class MyShopsView extends MvStatefulWidget<MyShopsViewModel> {
  static const ROUTE_NAME = "my-shops-view";

  MyShopsView({required MyShopsViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    List<ShopProfileComponent> shopItemsComponents = [];
    viewModel.shops.forEach(
        (shop) => shopItemsComponents.add(ShopProfileComponent(shop: shop)));

    return ScrollableParent(
        title: "My Shops",
        appBarColor: BreadCrumb.statusColors[3],
        hasDrawer: true,
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Container(
            margin: EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: shopItemsComponents,
            ),
          )
        ]));
  }
}
