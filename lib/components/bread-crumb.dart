import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class BreadCrumb extends StatelessWidget {
  static const statusColors = [
    IjudiColors.color2,
    IjudiColors.color3,
    IjudiColors.color4,
    IjudiColors.color1
  ];

  final String name;
  final Function onPressed;
  final Color color;
  final bool selected;
  final bool lowerCase;

  const BreadCrumb(
      {@required this.name,
      this.onPressed,
      this.color = IjudiColors.color1,
      this.lowerCase = true,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        margin: EdgeInsets.only(left: 8, bottom: 8),
        child: FilterChip(
          label: Text(lowerCase ? name.toLowerCase() : name,
              style: IjudiStyles.HEADER_TEXT),
          onSelected: (value) => onPressed(name),
          backgroundColor: color,
          selectedColor: IjudiColors.color5,
          selected: selected,
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
        ));
  }
}
