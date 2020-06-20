import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';

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

  static void launchURL(BuildContext context, {String url}) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: IjudiColors.color3,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],        
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}