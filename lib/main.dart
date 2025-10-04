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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  var localNotifications;
  SharedPrefStorageManager sharedPref;
  Config? config = Config.getProConfig();
  Config.currentConfig = config;

  sharedPref = await SharedPrefStorageManager.singleton();
  sharedPref.testEnvironment = false;

  var storage = await SecureStorageManager.singleton();

  var apiService = ApiService(storageManager: storage);
  localNotifications = NotificationService(apiService: apiService);
  await localNotifications.initialize();
  print("notification initialized");

  var navigation = NavigatorService(
      sharedPrefStorageManager: sharedPref,
      storageManager: storage,
      apiService: apiService,
      localNotificationService: localNotifications);
  runApp(MyApp(navigation: navigation));
}

class MyApp extends StatelessWidget {
  final NavigatorService? navigation;

  MyApp({Key? key, this.navigation}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iZinga',
      debugShowCheckedModeBanner: false,
      theme: JudiTheme().theme,
      darkTheme: JudiTheme().dark,
      initialRoute: AllShopsView.ROUTE_NAME,
      onGenerateRoute: navigation!.generateRoute,
    );
  }
}
