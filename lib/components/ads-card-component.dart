import 'package:flutter/material.dart';

class AdsCardComponent extends StatelessWidget {
  final Color color;
  final String imageUrl;

  AdsCardComponent({@required this.color, @required this.imageUrl});

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
              child: Image.network(imageUrl),
            )),
        );
  }
}
