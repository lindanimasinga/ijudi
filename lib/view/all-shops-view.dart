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
              children: <Widget>[
                AdsCardComponent(
                  color: IjudiColors.color3,
                  imageUrl: "https://www.foodinaminute.co.nz/var/fiam/storage/images/recipes/mexican-bean-and-corn-pies/7314837-14-eng-US/Mexican-Bean-and-Corn-Pies_recipeimage.jpg",
                ),
                AdsCardComponent(
                  color: IjudiColors.color2,
                  imageUrl: "https://sowetourban.co.za/wp-content/uploads/sites/112/2018/08/IMG_4251_27897_tn-520x400.jpg",
                ),
                AdsCardComponent(
                  color: IjudiColors.color1,
                  imageUrl: "https://snapsizzleandcook.co.za/wp-content/uploads/2018/07/images1.jpg",
                ),
                AdsCardComponent(
                  color: IjudiColors.color4,
                  imageUrl: "https://i.pinimg.com/236x/76/ab/66/76ab66a5e774d4deaf21ce7c02806a32--the-ad-advertising-design.jpg",
                )
              ]
            )
          ),
          Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
          Forms.searchField(context, "store name, bread, suger"),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text("Shops", style: Forms.INPUT_TEXT_STYLE,),
          ),
          Column(children: shopComponets)
        ],
      ));
  }
}