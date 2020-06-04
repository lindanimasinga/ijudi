import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class BreadCrumb extends StatelessWidget {
  
  static const statusColors = [IjudiColors.color2, 
            IjudiColors.color3, IjudiColors.color4, IjudiColors.color1];

  final String filterName;
  final Function onPressed;
  final Color color;

  const BreadCrumb({this.filterName, this.onPressed, this.color = IjudiColors.color1});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 35,
          margin: EdgeInsets.only(left: 8, bottom: 8),
          child: FlatButton(
            child: Text(filterName, style: IjudiStyles.CONTENT_TEXT),
            color: color,
            onPressed: () => onPressed(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )
          )
        );
  }
}