import 'package:flutter/material.dart';

class IJudiCard extends StatelessWidget {
  final Widget child;
  final double width;
  final Color color;
  final double elevation;

  IJudiCard({this.child, this.width = 352, this.color, this.elevation});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = deviceWidth > 360 ? 140 : 120;

    return Card(
      color: color,
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(width: width, height: null, child: child),
    );
  }

}