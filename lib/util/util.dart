import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/profile.dart';

class Utils {

  static double generateWaveNumber(int max) {
    var number;
    if(Random().nextBool()) {
      number = Random().nextDouble() >= 0.5 ? 0.8 : 0.4;
      return number;
    }
    number = Random().nextInt(max);
    return number > 0? number.toDouble() : generateWaveNumber(max);
  }

    static Shop createPlaceHolder() {
        return Shop(
        id: "1",
        name: "......",
        registrationNumber: "",
        mobileNumber: "...........",
        description: "..............",
        address: "............",
        imageUrl: "https://pbs.twimg.com/media/C1OKE9QXgAAArDp.jpg",
        role: ProfileRoles.STORE,
        yearsInService: 0,
        badges: 0,
        likes: 0,
        servicesCompleted: 0,
        bank: Bank(name: "Name", accountId: "Account", type: "Wallet"));
  } 

  static DateTime dateFromJson(String dateString) {
    if(dateString == null) return null;
    return DateTime.parse(dateString);
  }

  static String dateToJson(DateTime time) {
    var date =DateTime.now();
    var pickupDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return pickupDate.toIso8601String();
  }

    static TimeOfDay timeOfDayFromJson(String dateString) {
    if(dateString == null) return null;
    var date = DateTime.parse(dateString);
    return TimeOfDay.fromDateTime(date);
  }

  static String timeOfDayToJson(TimeOfDay time) {
    var date =DateTime.now();
    var pickupDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return pickupDate.toIso8601String();
  }
}