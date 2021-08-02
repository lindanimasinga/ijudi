import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';

class IjudiTimeInput extends StatelessWidget {
  final String hint;
  final Color color;
  final TextInputType type;
  final String text;
  final Function onChanged;
  final bool enabled;
  Iterable<String> autofillHints;

  IjudiTimeInput(
      {@required this.hint,
      this.autofillHints,
      this.enabled,
      this.color = IjudiColors.color5,
      this.type,
      this.text = "",
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    var controller = text == null
        ? null
        : TextEditingController.fromValue(TextEditingValue(
            text: text,
            selection:
                TextSelection.fromPosition(TextPosition(offset: text.length))));

    double width = MediaQuery.of(context).size.width > 360 ? 166 : 126;
    double width2 = MediaQuery.of(context).size.width > 360 ? 114 : 114;

    return Row(children: <Widget>[
      Container(
        color: color,
        width: width2,
        height: 52,
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
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
                onTap: () => timeIput(context).listen((value) {
                  if (value != null) {
                    onChanged(value);
                  }
                }),
                autofillHints: autofillHints,
                enabled: enabled,
                readOnly: true,
                onChanged: (value) => onChanged(value),
                decoration: InputDecoration(
                    hintText: hint,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 0.01,
                    ))),
              )))
    ]);
  }

  Stream<DateTime> timeIput(BuildContext context) {
    TimeOfDay timeOfDay = TimeOfDay.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 00),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    ).asStream()
    .map((time) => timeOfDay = time)
    .asyncMap((time) => showDatePicker(
        context: context,
        initialDate: DateTime.now()
            .add(Duration(days: 2, hours: time.hour, minutes: time.minute)),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30))))
    .map((dateTime) => DateTime(dateTime.year,dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute));
  }
}
