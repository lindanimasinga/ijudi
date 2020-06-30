import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/device.dart';
import 'package:ijudi/model/remote-message.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class NotificationService {
  
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static int notificationCount = 0;
  FirebaseMessaging _firebaseMessaging;
  final ApiService apiService;
  String _token;

  NotificationService({@required this.apiService});

  String get firebaseToken => _token;

  Future<bool> initialize() async {
    //push notification
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
        onResume: _onBackgroundPushMessageHandler,
        onBackgroundMessage: _onBackgroundPushMessageHandler);
    _firebaseMessaging.getToken()
        .then((value) {
            log("token: $value");
          if(apiService.storageManager.deviceId == null) {
            var device = Device(value); 
            apiService.registerDevice(device)
            .then((value) => log("device registered."));
            _token = value;
          } else {
            var device = Device(value); 
            device.id = apiService.storageManager.deviceId;
            device.userId = apiService.currentUserId;
            apiService.updateDevice(device)
            .then((value) => log("device updated."));
            _token = value;
          }
        });
    //local notification
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    return flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  void updateDeviceUser() {
    _firebaseMessaging.getToken()
        .then((value) {
                var device = Device(value); 
            device.id = apiService.storageManager.deviceId;
            device.userId = apiService.currentUserId;
            apiService.updateDevice(device)
            .then((value) => log("device updated."));
            _token = value;
        });
  }

  Future _onSelectNotification(String payload) async {
    log("notification selected");
  }

  Future scheduleLocalMessage(
    DateTime dateTime, String title, String body) async {

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    log("showing notification");
    await flutterLocalNotificationsPlugin.schedule(
        notificationCount++, title, body, dateTime, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  static Future _onBackgroundPushMessageHandler(Map<dynamic, dynamic> message) async {
    log("new notification");
    //log(json.encode(message));
    if (message.containsKey("data")) {
      // Handle data message
    log(json.encode(message["data"]));
    log("is data notification part");
    var newMessage = message.map((key, value) => MapEntry(key.toString(), value));
    var data = (newMessage["data"] as Map).map((key, value) => MapEntry(key.toString(), value)); 
    log("data is map $data"); 
    RemoteMessage remoteMessage = RemoteMessage.fromJson(data);
    log(json.encode(remoteMessage));

    BaseViewModel.analytics
          .logEvent(
            name: "push-notification",
            parameters: {
              "type" : remoteMessage.messageType,
            })
          .then((value) => {});

    var title;
    var body;

    switch(remoteMessage.messageType) {
      case MessageType.NEW_ORDER:
        title = "New Order Recieved";
        body = "Please confirm the order :)";
      break;
      case MessageType.NEW_ORDER_UPDATE:
        title = "Order Status Update";
        body = remoteMessage.messageContent;
      break;
      case MessageType.PAYMENT:
        title = "Order Payment Received";
        body = remoteMessage.messageContent;
      break;
      case MessageType.MARKETING:
      break;
    }

    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (value) async => {});

    log("showing notification");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        
    await flutterLocalNotificationsPlugin.schedule(
        notificationCount++, title, body, DateTime.now(), platformChannelSpecifics,
        androidAllowWhileIdle: true);
    }

    if (message.containsKey("notification")) {
      // Handle notification message
      log("is notification part");
      final dynamic notification = message['notification'];
      log(notification);
    }

    // Or do other work.
  }
}
