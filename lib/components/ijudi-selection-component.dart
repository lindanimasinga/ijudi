import 'package:flutter/material.dart';
import 'package:ijudi/model/selection-option.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class IjudiSelectionComponent extends StatefulWidget {
  final SelectionOption option;
  final Color color;

  IjudiSelectionComponent({
    this.option,
    this.color = IjudiColors.color5,
  });

  @override
  _IjudiSelectionComponent createState() => _IjudiSelectionComponent(
        option: option,
      );
}

class _IjudiSelectionComponent extends State<IjudiSelectionComponent> {
  Color color;
  final TextInputType type;
  final SelectionOption option;

  _IjudiSelectionComponent(
      {@required this.option, this.color = IjudiColors.color5, this.type});

  @override
  Widget build(BuildContext context) {
    List<Widget> choices = [];
    option?.values?.forEach((value) {
      choices.add(Row(
        children: <Widget>[
          Radio(
            value: value,
            groupValue: option.selected,
            onChanged: (selection) => selected = selection,
          ),
          Container( 
            width: 83,
            child:Text(value, style: Forms.INPUT_TEXT_STYLE, maxLines: 2)),
        ],
      ));
    });

    return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Table(children: [
          TableRow(
            children: [Text(option.name), Text("R ${Utils.formatToCurrency(option.price)}")],
          ),
          TableRow(children: [Column(children: choices), Container()])
        ]));
  }

  set selected(String selected) {
    option.selected = selected;
    setState(() {});
  }
}
