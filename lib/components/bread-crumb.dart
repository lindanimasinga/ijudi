import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class BreadCrumb extends StatelessWidget {
  static const statusColors = [
    IjudiColors.color2,
    IjudiColors.color1,
    IjudiColors.color3,
    IjudiColors.color3,
    IjudiColors.color4,
    IjudiColors.color4
  ];

  final String name;
  final Function? onPressed;
  final Color color;
  final bool selected;
  final bool lowerCase;

  const BreadCrumb(
      {required this.name,
      this.onPressed,
      this.color = IjudiColors.color1,
      this.lowerCase = true,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        margin: EdgeInsets.only(left: 8),
        child: FilterChip(
          label: name.length > 1
              ? Text(name[0].toUpperCase() + name.substring(1),
                  style: IjudiStyles.BREAD_CRUMB)
              : Text(name, style: IjudiStyles.BREAD_CRUMB),
          onSelected: (value) => onPressed!(name),
          backgroundColor: color,
          selectedColor: IjudiColors.color5,
          selected: selected,
          padding: EdgeInsets.only(left: 8, right: 8),
        ));
  }
}
