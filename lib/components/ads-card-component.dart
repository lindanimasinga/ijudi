import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/start-shopping.dart';

class AdsCardComponent extends StatelessWidget {
  final Color color;
  final Advert advert;
  final Shop? shop;

  AdsCardComponent({required this.color, required this.advert, this.shop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (advert.actionUrl != null) {
            Utils.launchURLInCustomeTab(context, url: advert.actionUrl!);
          } else if (shop != null) {
            Navigator.pushNamed(context, StartShoppingView.ROUTE_NAME,
                arguments: shop);
          }
        },
        child: Card(
            color: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: color, width: 3)),
            child: Container(
              width: MediaQuery.of(context).size.height * 0.35,
              height: MediaQuery.of(context).size.height * 0.35,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(advert.imageUrl!),
                    fit: BoxFit.cover,
                  )),
            )));
  }
}
