import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/model/advert.dart';

class AdsCardComponent extends StatelessWidget {
  final Color color;
  final Advert advert;

  AdsCardComponent({@required this.color, @required this.advert});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: color, width: 10)),
        child: Container(
          width: MediaQuery.of(context).size.height * 0.35,
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)),
          child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              child: CachedNetworkImage(imageUrl: advert.imageUrl),
            )),
        );
  }
}
