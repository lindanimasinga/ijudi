import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class StackedThumbnails extends StatelessWidget {
  final List<String>? urls;

  const StackedThumbnails({this.urls});

  @override
  Widget build(BuildContext context) {
    List<Widget> imagesComponents = [];
    for (int k = 0; k < urls!.length; k++) {
      imagesComponents.add(
          /* Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(pi/(2*k+3)),*/
          Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(urls![k]),
                  fit: BoxFit.cover,
                ),
              )) /*)*/);
    }
    return Stack(children: imagesComponents);
  }
}
