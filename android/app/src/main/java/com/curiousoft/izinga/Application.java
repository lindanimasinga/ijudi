package com.curiousoft.izinga;

import io.flutter.app.FlutterApplication;
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;

public class Application extends FlutterApplication {
  @Override
  public void onCreate() {
    super.onCreate();
   // FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
  }
}