import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/util/navigator-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/login-view.dart';

main() {
  print("starting application");
  UkhesheService.authenticate("0812815707", "Csd0148()1")
    .listen((event) {
      print("jwt response" + event.headerValue);
     });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iJudi',
      debugShowCheckedModeBanner: false,
      theme: JudiTheme().theme,
      darkTheme: JudiTheme().dark,
      initialRoute: LoginView.ROUTE_NAME,
      onGenerateRoute: NavigatorService.generateRoute,
    );
  }
}
