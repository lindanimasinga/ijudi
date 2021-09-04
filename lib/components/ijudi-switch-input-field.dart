import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class IjudiSwitchInputField extends StatefulWidget {
  final String? label;
  final Function? onChanged;
  final bool? active;
  final Color color;

  const IjudiSwitchInputField(
      {this.label,
      this.onChanged,
      this.active,
      this.color = IjudiColors.color5});

  @override
  _IjudiSwitchInputField createState() => _IjudiSwitchInputField(
      label: label, onChanged: onChanged, online: active, color: color);
}

class _IjudiSwitchInputField extends State<IjudiSwitchInputField> {
  final String? label;
  final Function? onChanged;
  final Color? color;

  bool? online;
  bool? get active => online;
  set active(bool? active) {
    online = active;
    setState(() {});
  }

  _IjudiSwitchInputField({this.label, this.onChanged, this.online, this.color});

  @override
  Widget build(BuildContext context) {
    double width2 = MediaQuery.of(context).size.width > 360 ? 114 : 84;
    return Row(children: <Widget>[
      Container(
        color: color,
        width: width2,
        height: 52.0,
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: Text(label!,
                maxLines: 2,
                style: Forms.INPUT_LABEL_STYLE,
                overflow: TextOverflow.ellipsis)),
      ),
      Container(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(top: 4, bottom: 0),
              child: Switch(
                  value: active!,
                  onChanged: (value) {
                    active = value;
                    onChanged!(value);
                  })))
    ]);
  }
}
