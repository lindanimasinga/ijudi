import 'dart:math';

import 'package:flutter/material.dart';

class IjudyHeaderClipPath extends CustomClipper<Path>{
  
  Parts part;
  double? waves;
  double amplitude;
  double height;

  IjudyHeaderClipPath({required this.part, 
    this.amplitude = 100,
    required this.height,
    this.waves = 0.5});
  
  @override
  Path getClip(Size size) {
    
    Path path = Path();
    double width = size.width;
    waves = size.width/(4 * waves!) ;

    switch(part) {
      case Parts.FIRST:
        path.lineTo(0, 0);

        path.lineTo(0, height);
        for(double xValue= waves!; xValue < width; xValue = xValue + 2 * waves!) {
          var yValue = height + amplitude;
          path.quadraticBezierTo(xValue, yValue, xValue + waves!, height);
          amplitude = -1 * amplitude;
        }
        
        //path.quadraticBezierTo(width*4/8, height/2, width, height/1.3);
       // path.quadraticBezierTo(width/8, height, width*4/8, height/1.8);
        path.lineTo(width, 0.0);
        break;
      case Parts.SECOND:
                path.lineTo(0, 0);
        path.lineTo(0, height);
        for(double xValue= waves!; xValue < width; xValue = xValue + 2 * waves!) {
          var yValue = height + amplitude;
          path.quadraticBezierTo(xValue, yValue, xValue + waves!, height);
          amplitude = -1 * amplitude;
        }
        path.lineTo(width, 0.0);
        break;
      case Parts.THIRD:
                path.lineTo(0, 0);
        path.lineTo(0, height);
        for(double xValue= waves!; xValue < width; xValue = xValue + 2 * waves!) {
          var yValue = height + amplitude;
          path.quadraticBezierTo(xValue, yValue, xValue + waves!, height);
          amplitude = -1 * amplitude;
        }
        path.lineTo(width, 0.0);
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

  enum Parts {
    FIRST,
    SECOND,
    THIRD
  }