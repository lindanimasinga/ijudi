import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/device.dart';
import 'package:ijudi/model/remote-message.dart' as FirebaseContent;
import 'package:ijudi/viewmodel/base-view-model.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static int notificationCount = 0;
  late FirebaseMessaging _firebaseMessaging;
  final ApiService apiService;
  String? _token;

  NotificationService({required this.apiService});

  String? get firebaseToken => _token;

  Future<bool?> initialize() async {
    //push notification
    FirebaseMessaging.onBackgroundMessage(_onBackgroundPushMessageHandler);
    FirebaseMessaging.onMessage.listen(_onForegroundPushMessageHandler);

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((value) {
      log("token: $value");
      if (apiService.storageManager?.deviceId == null) {
        var device = Device(value);
        apiService
            .registerDevice(device)
            .then((value) => log("device registered."));
        _token = value;
      }
    });
    //local notification
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    return flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  void updateDeviceUser(String userId) {
    _firebaseMessaging.getToken().then((value) {
      var device = Device(value);
      device.id = apiService.storageManager!.deviceId;
      device.userId = userId;
      log("user is ${apiService.currentUserId}");
      apiService.updateDevice(device).then((value) => log("device updated."));
      _token = value;
    });
  }

  Future _onSelectNotification(String? payload) async {
    log("notification selected $payload");
  }

  Future scheduleLocalMessage(
      DateTime dateTime, String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    log("showing notification");
    await flutterLocalNotificationsPlugin.schedule(
        notificationCount++, title, body, dateTime, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  static Future _onBackgroundPushMessageHandler(RemoteMessage message) async {
    log("new notification");
    //log(json.encode(message));
    if (message.data.isNotEmpty) {
      log(json.encode(message.data));
      log("is data notification part");
      FirebaseContent.RemoteMessage remoteMessage =
          FirebaseContent.RemoteMessage.fromJson(message.data);
      log(json.encode(remoteMessage));

      BaseViewModel.analytics
          .logEvent(name: "notifications.push.type", parameters: {
        "type": remoteMessage.messageType,
      }).then((value) => {});

      var title;
      var body;

      switch (remoteMessage.messageType) {
        case FirebaseContent.MessageType.NEW_ORDER:
          title = "New Order Recieved";
          body = remoteMessage.messageContent;
          break;
        case FirebaseContent.MessageType.NEW_ORDER_UPDATE:
          title = "Order Status";
          body = remoteMessage.messageContent;
          break;
        case FirebaseContent.MessageType.PAYMENT:
          title = "Order Payment Received";
          body = remoteMessage.messageContent;
          break;
        case FirebaseContent.MessageType.MARKETING:
          break;
      }

      var initializationSettingsAndroid =
          AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (value) async => {});

      log("showing notification");
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name',
          importance: Importance.max, priority: Priority.high);
      var iOSPlatformChannelSpecifics =
          IOSNotificationDetails(presentAlert: true, presentSound: true);
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.schedule(notificationCount++, title,
          body, DateTime.now(), platformChannelSpecifics,
          androidAllowWhileIdle: true);
    }
  }

  _onForegroundPushMessageHandler(RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    flutterLocalNotificationsPlugin.show(notification.hashCode,
        notification.title, notification.body, NotificationDetails());
  }
}
