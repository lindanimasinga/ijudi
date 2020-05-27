import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class IjudiTimeInput extends StatelessWidget {
  final String hint;
  final Color color;
  final TextInputType type;
  final String text;
  final Function onTap;
  final bool enabled;
  Iterable<String> autofillHints;

  IjudiTimeInput(
      {@required this.hint,
      this.autofillHints,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      this.text = "",
      this.onTap});

  @override
  Widget build(BuildContext context) {
    var controller = text == null
        ? null
        : TextEditingController.fromValue(TextEditingValue(
            text: text,
            selection:
                TextSelection.fromPosition(TextPosition(offset: text.length))));

    double width = MediaQuery.of(context).size.width > 360 ? 190 : 150;
    double width2 = MediaQuery.of(context).size.width > 360 ? 90 : 90;

    return Row(children: <Widget>[
      Container(
        color: color,
        width: width2,
        height: 52,
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(hint,
                style: Forms.INPUT_LABEL_STYLE,
                overflow: TextOverflow.ellipsis)),
      ),
      Container(
          width: width,
          child: Padding(
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 0),
              child: TextField(
                controller: controller,
                keyboardType: type,
                onTap: () => timeIput(context)
                              .then((value) {
                                if(value != null)
                                onTap(value);
                              }),
                autofillHints: autofillHints,
                enabled: enabled,
                readOnly: true,
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

  Future<TimeOfDay> timeIput(BuildContext context) {
   return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
  }
}
