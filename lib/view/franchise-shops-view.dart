import 'package:flutter/material.dart';
import 'package:ijudi/components/featured-shop.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';

import '../viewmodel/franchise-shops-view-model.dart';

class FranchiseShopsView extends MvStatefulWidget<FranchiseShopsViewModel> {
  static const ROUTE_NAME = "franchise";

  FranchiseShopsView({required FranchiseShopsViewModel viewModel})
      : super(viewModel);

  @override
  Widget build(BuildContext context) {
    var featuredShopComponents =
        viewModel.shops.map((shop) => FeaturedShop(shop: shop)).toList();

    return ScrollableParent(
        hasDrawer: false,
        title: viewModel.shops.first.franchiseName!,
        child: Column(
          children: <Widget>[
            featuredShopComponents.isEmpty
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Text("Shops", style: IjudiStyles.HEADER_2),
                  ),
            Column(children: featuredShopComponents),
          ],
        ));
  }
}
