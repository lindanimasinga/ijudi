import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class StackedThumbnails extends StatelessWidget {
  final List<String> urls;

  const StackedThumbnails({this.urls});

  @override
  Widget build(BuildContext context) {
    List<Widget> imagesComponents = [];
    for (int k=0; k< urls.length; k++) {
      imagesComponents.add(
        Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationZ(pi/(2*k+3)),
          child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: IjudiColors.color3,
                  width: 3,
                ),
                image: DecorationImage(
                  image: NetworkImage(urls[k]),
                  fit: BoxFit.cover,
                ),
              ))));
    }
    return Stack(children: imagesComponents);
  }
}
