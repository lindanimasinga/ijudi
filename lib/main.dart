import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/util/navigator-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/login-view.dart';

main() {
  print("starting application");
  WidgetsFlutterBinding.ensureInitialized();
  var localNotifications = LocalNotificationService();
  localNotifications.initialize().then((value) => {
    print("notification initialized $value")
  });
  SharedPrefStorageManager.singleton()
    .then((storage)  {
      var ukhesheService = UkhesheService(storage);
      var apiService = ApiService(storage);
      var navigation = NavigatorService(
        storageManager: storage, 
        apiService: apiService,
        ukhesheService: ukhesheService,
        localNotificationService: localNotifications);
      runApp(MyApp(navigation: navigation));
  });
}

class MyApp extends StatelessWidget {

  final NavigatorService navigation;

  MyApp({Key key, this.navigation}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      title: 'iJudi',
      debugShowCheckedModeBanner: false,
      theme: JudiTheme().theme,
      darkTheme: JudiTheme().dark,
      initialRoute: LoginView.ROUTE_NAME,
      onGenerateRoute: navigation.generateRoute,
    );
  }
}
