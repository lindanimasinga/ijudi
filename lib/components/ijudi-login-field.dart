import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class IjudiLoginField extends StatelessWidget {
  
  final String hint;
  final Color color;
  final List<String> autofillHints;
  final Icon icon;
  final TextInputType type;
  final Function onTap;
  final bool enabled;
  final String text;

  IjudiLoginField(
      {@required this.hint,
      this.enabled,
      this.color = IjudiColors.color5,
      @required this.autofillHints,
      this.icon,
      this.onTap, 
      this.type = TextInputType.text, 
      @required this.text});

  @override
  Widget build(BuildContext context) {
    var controller = text == null? null : TextEditingController.fromValue(TextEditingValue(
        text: text,
        selection:
            TextSelection.fromPosition(TextPosition(offset: text.length))));
    double width = MediaQuery.of(context).size.width > 360 ? 166 : 146;
    double width2 = MediaQuery.of(context).size.width > 360 ? 114 : 84;
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
                controller : controller,
                autofillHints: autofillHints,
                obscureText: autofillHints.contains("password") || autofillHints.contains("newPassword"),
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
