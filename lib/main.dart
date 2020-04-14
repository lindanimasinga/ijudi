import 'package:flutter/material.dart';
import 'package:ijudi/util/navigator-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/menu-view.dart';
import 'package:ijudi/view/profile-view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iJudi',
      debugShowCheckedModeBanner: false,
      theme: JudiTheme().theme,
      initialRoute: MenuView.ROUTE_NAME,
      routes: NavigatorService.getNavigationRoute(),
    );
  }
}
