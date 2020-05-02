import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class IjudiInputField extends StatelessWidget {
  String hint;
  Color color;
  TextInputType type;
  String text;
  Function onTap;
  bool enabled;

  IjudiInputField(
      {@required this.hint,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      this.text,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController.fromValue(TextEditingValue(
        text: text,
        selection:
            TextSelection.fromPosition(TextPosition(offset: text.length))));

    return Row(children: <Widget>[
      Container(
        color: color,
        width: 90,
        height: 52,
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(hint,
                style: Forms.INPUT_LABEL_STYLE,
                overflow: TextOverflow.ellipsis)),
      ),
      Container(
          width: 190,
          child: Padding(
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 0),
              child: TextField(
                controller: controller,
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
