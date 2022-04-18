
import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class IjudiInputField extends StatefulWidget {
  final String hint;
  final Color color;
  final TextInputType? type;
  final String? text;
  final Function? onChanged;
  final bool enabled;
  final Function? error;
  Iterable<String>? autofillHints;
  final int lines;

  IjudiInputField(
      {required this.hint,
      this.autofillHints,
      this.enabled = true,
      this.color = IjudiColors.color5,
      this.type,
      this.text = "",
      this.error,
      this.onChanged,
      this.lines = 0});

  @override
  _IjudiInputFieldState createState() => _IjudiInputFieldState(
      hint: hint,
      enabled: enabled,
      lines: lines,
      color: color,
      autofillHints: autofillHints,
      onChanged: onChanged,
      type: type,
      error: error,
      text: text);
}

class _IjudiInputFieldState extends State<IjudiInputField> {
  final String hint;
  Color color;
  final TextInputType? type;
  final int? lines;
  String? text;
  Function? onChanged;
  bool enabled;
  Function? error;
  String? errorText = "";
  Iterable<String>? autofillHints;

  _IjudiInputFieldState(
      {required this.hint,
      this.autofillHints,
      this.enabled = true,
      this.lines,
      this.color = IjudiColors.color5,
      this.type,
      this.text = "",
      this.error,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    errorText = errorText!.isEmpty && error != null ? error!() : errorText;
    var controller = text == null
        ? null
        : TextEditingController.fromValue(TextEditingValue(
            text: text!,
            selection:
                TextSelection.fromPosition(TextPosition(offset: text!.length))));

    double width = MediaQuery.of(context).size.width > 360 ? 166 : 126;
    double width2 = MediaQuery.of(context).size.width > 360 ? 114 : 114;

    return Row(
      children: <Widget>[
      Container(
        color: errorText is String && errorText!.isNotEmpty
            ? IjudiColors.color2
            : color,
        width: width2,
        height: 52.0 + 15 * lines!,
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: Text(hint,
                maxLines: 2,
                style: Forms.INPUT_LABEL_STYLE,
                overflow: TextOverflow.ellipsis)),
      ),
      Container(
          width: width,
          child: Padding(
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 0),
              child: Stack(children: [
                TextField(
                  maxLines: lines == 0 ? 1 : lines,
                  controller: controller,
                  keyboardType: type,
                  autofillHints: enabled? autofillHints : null,
                  enabled: enabled,
                  onChanged: (value) {
                    text = value;
                    validate(value);
                    onChanged!(value);
                  },
                  decoration: InputDecoration(
                      hintText: hint,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        width: 0.01,
                      ))),
                ),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(errorText!, style: IjudiStyles.FORM_ERROR))
              ])))
    ]);
  }

  void validate(String value) {
    if (autofillHints == null) return;

    if (autofillHints!.contains(AutofillHints.telephoneNumber)) {
      errorText = value.length < 10 || Utils.validSANumber(value)
          ? ""
          : "Invalid SA mobile number";
      setState(() {});
      return;
    }

    if (autofillHints!.contains("idNumber")) {
      errorText = value.length < 13 || Utils.isValidSAId(value)
          ? ""
          : "Invalid SA Id number";
      setState(() {});
      return;
    }

    if (autofillHints!.contains(AutofillHints.email)) {
      errorText = value.length < 6 || Utils.isEmail(value)
          ? ""
          : "contiue enter valid email";
      setState(() {});
      return;
    }
  }
}
