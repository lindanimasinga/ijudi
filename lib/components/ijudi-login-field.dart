import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class IjudiLoginField extends StatelessWidget {
  String hint;
  Color color;
  TextInputType type;
  Icon icon;
  Function onTap;
  bool enabled;

  IjudiLoginField(
      {@required this.hint,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width > 360 ? 190 : 170;
    double width2 = MediaQuery.of(context).size.width > 360 ? 90 : 60;
    return Row(children: <Widget>[
      Container(
        color: color,
        width: width2,
        height: 52,
        alignment: Alignment.center,
        child: icon),
      Container(
          width: width,
          child: Padding(
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 0),
              child: TextField(
                keyboardType: type,
                enabled: enabled,
                onChanged: (value) => onTap(value),
                decoration: InputDecoration(
                    hintText: hint,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 0.01,
                    ))),
              )))
    ]);
  }
}
