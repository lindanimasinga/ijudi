package com.curiousoft.izinga;

import io.flutter.app.FlutterApplication;

public class Application extends FlutterApplication {
  @Override
  public void onCreate() {
    super.onCreate();
   // FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
  }
}