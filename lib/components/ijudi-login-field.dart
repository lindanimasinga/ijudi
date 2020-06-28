import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class IjudiLoginField extends StatefulWidget {
  final String hint;
  final Color color;
  final List<String> autofillHints;
  final Icon icon;
  final TextInputType type;
  final Function onTap;
  final bool enabled;
  final Function text;
  Function error;

  IjudiLoginField(
      {@required this.hint,
      this.enabled,
      this.color = IjudiColors.color5,
      @required this.autofillHints,
      this.icon,
      this.onTap,
      this.type = TextInputType.text,
      this.error,
      @required this.text});

  @override
  _IjudiLoginFieldState createState() => _IjudiLoginFieldState(
      hint: hint,
      enabled: enabled,
      color: color,
      autofillHints: autofillHints,
      icon: icon,
      onTap: onTap,
      type: type,
      error: error,
      text: text);
}

class _IjudiLoginFieldState extends State<IjudiLoginField> {
  final String hint;
  Color color;
  final List<String> autofillHints;
  Icon icon;
  final TextInputType type;
  final Function onTap;
  bool enabled;
  Function text;
  Function error;
  String errorText = "";

  _IjudiLoginFieldState(
      {@required this.hint,
      this.enabled,
      this.color = IjudiColors.color5,
      @required this.autofillHints,
      this.icon,
      this.onTap,
      this.type = TextInputType.text,
      this.error,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    errorText = errorText.isEmpty && error != null ? error() : errorText; 
    var controller = text == null
        ? null
        : TextEditingController.fromValue(TextEditingValue(
            text: text(),
            selection:
                TextSelection.fromPosition(TextPosition(offset: text().length))));
    double width = MediaQuery.of(context).size.width > 360 ? 166 : 146;
    double width2 = MediaQuery.of(context).size.width > 360 ? 114 : 84;
    return Row(children: <Widget>[
      Container(
          color:
              errorText is String && errorText.isNotEmpty ? IjudiColors.color2 : color,
          width: width2,
          height: 52,
          alignment: Alignment.center,
          child: icon),
      Container(
          width: width,
          child: Padding(
              padding: EdgeInsets.only(left: 8, top: 0, bottom: 0),
              child: Stack(children: [
                TextField(
                    controller: controller,
                    autofillHints: autofillHints,
                    obscureText: autofillHints.contains("password") ||
                        autofillHints.contains("newPassword"),
                    keyboardType: type,
                    enabled: enabled,
                    onChanged: (value) {
                      validate(value);
                      onTap(value);
                    },
                    decoration: InputDecoration(
                      hintText: hint,
                      contentPadding: EdgeInsets.only(bottom: 0, top: 0),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    )),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(errorText, style: IjudiStyles.FORM_ERROR))
              ])))
    ]);
  }

  void validate(String value) {
    if (autofillHints.contains(AutofillHints.telephoneNumber)) {
      errorText = value.length < 10 || Utils.validSANumber(value)
          ? ""
          : "Invalid SA Mobile Number";
      return;
    }
  }
}
