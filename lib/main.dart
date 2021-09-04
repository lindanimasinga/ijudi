import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/services/impl/secure-storage-manager.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/util/navigator-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';

import 'config.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  var localNotifications;
  SharedPrefStorageManager? sharedPref;
  Config? config = Config.getProConfig();
  Config.currentConfig = config;
  Firebase.initializeApp()
      .asStream()
      .map((event) {
        // Pass all uncaught errors from the framework to Crashlytics.
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      })
      // .asyncExpand((event) => RemoteConfig.instance.asStream())
      .asyncExpand(((event) => SharedPrefStorageManager.singleton().asStream()))
      .map((event) {
        sharedPref = event as SharedPrefStorageManager?;
        //config = sharedPref.testEnvironment ? Config.getUATConfig() : Config.getProConfig();
        sharedPref!.testEnvironment = false;
        return sharedPref;
      })
      .asyncExpand(((event) => SecureStorageManager.singleton().asStream()))
      .listen((storage) {
        var apiService = ApiService(storageManager: storage);
        localNotifications = NotificationService(apiService: apiService);
        localNotifications
            .initialize()
            .then((value) => print("notification initialized $value"));

        var navigation = NavigatorService(
            sharedPrefStorageManager: sharedPref,
            storageManager: storage,
            apiService: apiService,
            localNotificationService: localNotifications);
        runApp(MyApp(navigation: navigation));
      });
}

class MyApp extends StatelessWidget {
  final NavigatorService? navigation;

  MyApp({Key? key, this.navigation}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iJudi',
      debugShowCheckedModeBanner: false,
      theme: JudiTheme().theme,
      darkTheme: JudiTheme().dark,
      initialRoute: AllShopsView.ROUTE_NAME,
      onGenerateRoute: navigation!.generateRoute,
    );
  }
}
