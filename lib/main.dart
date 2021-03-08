import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/services/impl/secure-storage-manager.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/util/navigator-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/choose-location-view.dart';
import 'package:ijudi/view/introduction-view.dart';

import 'config.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  var localNotifications;
  SharedPrefStorageManager sharedPref;
  Config config = Config.getProConfig();
  Config.currentConfig = config;
  Firebase.initializeApp()
      .asStream()
      .map((event) {
        // Pass all uncaught errors from the framework to Crashlytics.
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      })
      // .asyncExpand((event) => RemoteConfig.instance.asStream())
      .asyncExpand((event) => SharedPrefStorageManager.singleton().asStream())
      .map((event) {
        sharedPref = event;
        //config = sharedPref.testEnvironment ? Config.getUATConfig() : Config.getProConfig();
        sharedPref.testEnvironment = false;
        return sharedPref;
      })
      .asyncExpand((event) => SecureStorageManager.singleton().asStream())
      .listen((storage) {
        var ukhesheBaseURL = config.ukhesheBaseURL;
        var iZingaApiUrl = config.iZingaApiUrl;
        var ukhesheService =
            UkhesheService(storageManager: storage, baseUrl: ukhesheBaseURL);
        var apiService =
            ApiService(storageManager: storage, apiUrl: iZingaApiUrl);
        localNotifications = NotificationService(apiService: apiService);
        localNotifications
            .initialize()
            .then((value) => print("notification initialized $value"));

        var navigation = NavigatorService(
            sharedPrefStorageManager: sharedPref,
            storageManager: storage,
            apiService: apiService,
            ukhesheService: ukhesheService,
            localNotificationService: localNotifications);
        runApp(MyApp(navigation: navigation));
      });

  Geolocator.checkPermission().asStream().map((permission) {
    print("permission $permission");
    if (permission == null || permission == LocationPermission.denied) {
      Geolocator.requestPermission().then((value) => null);
    }
  }).listen((event) {});
}

class MyApp extends StatelessWidget {
  final NavigatorService navigation;

  MyApp({Key key, this.navigation}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iJudi',
      debugShowCheckedModeBanner: false,
      theme: JudiTheme().theme,
      darkTheme: JudiTheme().dark,
      initialRoute: ChooseLocationView.ROUTE_NAME,
      onGenerateRoute: navigation.generateRoute,
    );
  }
}
