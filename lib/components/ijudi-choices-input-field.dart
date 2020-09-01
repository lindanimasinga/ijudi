import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/model/selection-option.dart';
import 'package:ijudi/util/theme-utils.dart';

class IjudiChoicesInputField extends StatefulWidget {
  final String hint;
  final String choicesHint;
  final int optionNumber;
  final SelectionOption option;
  final Color color;
  final TextInputType type;
  final Function onNameChanged;
  final Function onOptionsChanged;
  final Function onPriceChanged;
  final Function onRemove;
  final bool enabled;
  final Function error;

  IjudiChoicesInputField({
    @required this.hint,
    this.enabled,
    this.optionNumber,
    this.option,
    this.color = IjudiColors.color5,
    this.type,
    this.error,
    @required this.choicesHint,
    this.onNameChanged,
    this.onOptionsChanged,
    this.onPriceChanged,
    this.onRemove,
  });

  @override
  _IjudiChoicesInputField createState() => _IjudiChoicesInputField(
      hint: hint,
      choicesHint: choicesHint,
      optionNumber: optionNumber,
      option: option,
      enabled: enabled,
      color: color,
      onNameChanged: onNameChanged,
      onOptionsChanged: onOptionsChanged,
      onPriceChanged: onNameChanged,
      onRemove: onRemove,
      type: type,
      error: error);
}

class _IjudiChoicesInputField extends State<IjudiChoicesInputField> {
  final String hint;
  final String choicesHint;
  Color color;
  final TextInputType type;
  String text;
  final int optionNumber;
  final SelectionOption option;
  final Function onNameChanged;
  final Function onOptionsChanged;
  final Function onPriceChanged;
  final Function onRemove;
  bool enabled;
  Function error;
  String errorText = "";

  _IjudiChoicesInputField(
      {@required this.hint,
      @required this.choicesHint,
      @required this.optionNumber,
      @required this.option,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      this.text = "",
      this.error,
      this.onNameChanged,
      this.onOptionsChanged,
      this.onPriceChanged,
      this.onRemove});

  @override
  Widget build(BuildContext context) {
    errorText = errorText.isEmpty && error != null ? error() : errorText;
    var controller = option.name == null
        ? null
        : TextEditingController.fromValue(TextEditingValue(
            text: option.name,
            selection:
                TextSelection.fromPosition(TextPosition(offset: text.length))));

    return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Option ${optionNumber + 1}"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: IconButton(
                  icon: Icon(Icons.cancel, color: IjudiColors.color2),
                  onPressed: () => onRemove(optionNumber)),
            )
          ]),
          TextField(
            controller: controller,
            enabled: enabled,
            onChanged: (value) {
              option.name = value;
            },
            decoration: InputDecoration(
              hintText: hint,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 0.01,
              )),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            enabled: enabled,
            onChanged: (value) {
              option.price = double.parse(value);
            },
            decoration: InputDecoration(
              hintText: "R0",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 0.01,
              )),
            ),
          ),
          TextField(
            maxLines: 3,
            onChanged: (value) {
              text = value;
              option.values = value.split(",");
            },
            decoration: InputDecoration(
                hintText: choicesHint,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  width: 0.01,
                ))),
          ),
        ]));
  }
}
