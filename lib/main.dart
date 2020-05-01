import 'package:flutter/material.dart';
import 'package:ijudi/util/navigator-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iJudi',
      debugShowCheckedModeBanner: false,
      theme: JudiTheme().theme,
      darkTheme: JudiTheme().dark,
      initialRoute: AllShopsView.ROUTE_NAME,
      onGenerateRoute: NavigatorService.generateRoute,
    );
  }
}
