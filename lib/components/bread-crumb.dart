import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class BreadCrumb extends StatelessWidget {
  
  static const statusColors = [IjudiColors.color2, 
            IjudiColors.color3, IjudiColors.color4, IjudiColors.color1];

  final String filterName;
  final Function onPressed;
  final Color color;
  final bool selected;

  const BreadCrumb({
    @required this.filterName, 
    this.onPressed, 
    this.color = IjudiColors.color1, 
    @required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 35,
          margin: EdgeInsets.only(left: 8, bottom: 8),
          child: FilterChip(
            label: Text(filterName.toLowerCase(), style: IjudiStyles.HEADER_TEXT), 
            onSelected:  (value) => onPressed(filterName),
            backgroundColor: color,
            selectedColor: IjudiColors.color5,
            selected: selected,
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
          )
        );
  }
}