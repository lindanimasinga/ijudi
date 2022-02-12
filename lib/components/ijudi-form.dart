import 'package:flutter/material.dart';

class IjudiForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Widget? child;

  IjudiForm({this.child});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 360 ? 280 : 240;
    return Container(
        width: width,
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            child: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: child,
            )));
  }
}
