import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';

abstract class BaseViewModel<T extends StatefulWidget> extends State<T> {

  Function buildFunction;

  @override
  Widget build(BuildContext context) {
    return buildFunction(context);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {

  }

  notifyChanged() => setState(() {});

  get currentUser => ApiService.findUserById("s");

}