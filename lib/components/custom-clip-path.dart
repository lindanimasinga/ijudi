import 'package:flutter/material.dart';

class IjudyHeaderClipPath extends CustomClipper<Path>{
  
  Parts part;

  IjudyHeaderClipPath({@required this.part});
  
  @override
  Path getClip(Size size) {
    
    Path path = Path();
    double width = size.width;

    switch(part) {
      case Parts.FIRST:
        double  height = 445;
        path.lineTo(0, 0);
        path.lineTo(0, height);
        path.quadraticBezierTo(0, height, width, 190);
        path.lineTo(width, 0.0);
        break;
      case Parts.SECOND:
        double  height = 384;
        path.lineTo(0, 0);
        path.lineTo(0, height);
        path.quadraticBezierTo(0, height, width, 68);
        path.lineTo(width, 0.0);
        break;
      case Parts.THIRD:
        double  height = 183;
        path.lineTo(0, 0);
        path.lineTo(0, height);
        path.quadraticBezierTo(0, height, width, 62);
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