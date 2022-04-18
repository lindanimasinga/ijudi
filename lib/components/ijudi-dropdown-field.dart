import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class IjudiDropDownField<T> extends StatefulWidget {
  final String hint;
  final Color color;
  final TextInputType? type;
  final List options;
  final Function? onSelected;
  final bool? enabled;
  final Function? error;
  final Iterable<String>? autofillHints;
  T? initial;

  IjudiDropDownField(
      {required this.hint,
      this.autofillHints,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      this.options = const [],
      this.error,
      this.initial,
      this.onSelected});

  @override
  _IjudiDropDownFieldState createState() => _IjudiDropDownFieldState(
      hint: hint,
      enabled: enabled,
      color: color,
      autofillHints: autofillHints,
      onSelected: onSelected,
      initial: initial,
      type: type,
      error: error,
      options: options);
}

class _IjudiDropDownFieldState<T> extends State<IjudiDropDownField> {
  final String hint;
  Color color;
  final TextInputType? type;
  List<T> options;
  T? initial;
  Function? onSelected;
  bool? enabled;
  Function? error;
  String errorText = "";
  Iterable<String>? autofillHints;
  T? _selected;

  _IjudiDropDownFieldState(
      {required this.hint,
      this.autofillHints,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      this.options = const [],
      this.error,
      this.initial,
      this.onSelected}) {
    if (selected == null) {
      _selected = initial;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 360 ? 166 : 126;
    double width2 = MediaQuery.of(context).size.width > 360 ? 114 : 114;

    return Row(children: <Widget>[
      Container(
        color: errorText is String && errorText.isNotEmpty
            ? IjudiColors.color2
            : color,
        width: width2,
        height: 52,
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
          height: 52,
          child: Padding(
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 0),
              child: DropdownButton<T>(
                value: selected,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: IjudiStyles.SUBTITLE_2,
                underline: Container(
                  height: 1,
                  color: IjudiColors.color6,
                ),
                onChanged: (T? newValue) {
                  selected = newValue;
                  print(newValue);
                  onSelected!(newValue);
                },
                items: options
                    .map((value) => DropdownMenuItem<T>(
                          value: value,
                          child: Text(describeEnum(value!)),
                        ))
                    .toList(),
              )))
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

  T? get selected => _selected;
  set selected(T? selected) {
    _selected = selected;
    setState(() {});
  }
}
