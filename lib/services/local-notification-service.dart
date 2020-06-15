import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<bool> initialize() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); 
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    return flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future _onSelectNotification(String payload) async {
    log("notification selected");
  }

  Future scheduleMessage(DateTime dateTime, String title, String body) async {
  
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);

  var iOSPlatformChannelSpecifics =  IOSNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  log("showing notification");
  await flutterLocalNotificationsPlugin.schedule(
        0,
        title,
        body,
        dateTime,
        platformChannelSpecifics, 
        androidAllowWhileIdle: true);
}
  
}