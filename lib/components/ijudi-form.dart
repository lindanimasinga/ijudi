import 'package:flutter/material.dart';

class IjudiForm extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>(); 
  final Widget child;

  IjudiForm({this.child});

  @override
  Widget build(BuildContext context) {
        return Container(
      width: 310,
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
        child:  
            Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: child,
              )
      )
    );
  }
}