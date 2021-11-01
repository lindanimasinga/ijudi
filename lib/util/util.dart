import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:intl/intl.dart';

class Utils {
  static const orderStatusColors = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: IjudiColors.color2,
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: IjudiColors.color2,
    OrderStage.STAGE_2_STORE_PROCESSING: IjudiColors.color3,
    OrderStage.STAGE_3_READY_FOR_COLLECTION: IjudiColors.color4,
    OrderStage.STAGE_4_ON_THE_ROAD: IjudiColors.color1,
    OrderStage.STAGE_5_ARRIVED: IjudiColors.color5,
    OrderStage.STAGE_6_WITH_CUSTOMER: IjudiColors.color6,
    OrderStage.STAGE_7_ALL_PAID: IjudiColors.color4
  };

  static const statusText = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "Not Paid",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "Waiting Confirmation",
    OrderStage.STAGE_2_STORE_PROCESSING: "Processing",
    OrderStage.STAGE_3_READY_FOR_COLLECTION: "Ready For Collection",
    OrderStage.STAGE_4_ON_THE_ROAD: "Arriving",
    OrderStage.STAGE_5_ARRIVED: "Arrived",
    OrderStage.STAGE_6_WITH_CUSTOMER: "Delivered",
    OrderStage.STAGE_7_ALL_PAID: "Completed"
  };

  static const LOTTIE_BY_STAGE = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "assets/lottie/loading.json",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "assets/lottie/loading.json",
    OrderStage.STAGE_2_STORE_PROCESSING: "assets/lottie/pan.json",
    OrderStage.STAGE_3_READY_FOR_COLLECTION: "assets/lottie/food.json",
    OrderStage.STAGE_4_ON_THE_ROAD: "assets/lottie/delivery.json",
    OrderStage.STAGE_5_ARRIVED: "assets/lottie/loading.json",
    OrderStage.STAGE_6_WITH_CUSTOMER: "assets/lottie/food.json"
  };

  static const onlineDeliveryStages = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: 0,
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: 1,
    OrderStage.STAGE_2_STORE_PROCESSING: 2,
    OrderStage.STAGE_3_READY_FOR_COLLECTION: 3,
    OrderStage.STAGE_4_ON_THE_ROAD: 4,
    OrderStage.STAGE_5_ARRIVED: 5,
    OrderStage.STAGE_6_WITH_CUSTOMER: 6,
    OrderStage.STAGE_7_ALL_PAID: 7
  };

  static Map<OrderStage, String> messageMap(Shop? shop) => {
        OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "assets/lottie/loading.json",
        OrderStage.STAGE_1_WAITING_STORE_CONFIRM:
            "Waiting for shop ${shop?.name} to accept your order. This may take a few minutes.",
        OrderStage.STAGE_2_STORE_PROCESSING:
            "${shop?.name} is now processing your order",
        OrderStage.STAGE_3_READY_FOR_COLLECTION:
            "The driver is now collecting your. Brace yourself..",
        OrderStage.STAGE_4_ON_THE_ROAD: "The driver is on his way",
        OrderStage.STAGE_5_ARRIVED:
            "The driver has arrived. Please come collect.",
        OrderStage.STAGE_6_WITH_CUSTOMER:
            "You have received your order, Give us a review."
      };

  static const shopStatusText = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "Not Paid",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "Please confirm the order",
    OrderStage.STAGE_2_STORE_PROCESSING: "Is the order ready?",
    OrderStage.STAGE_3_READY_FOR_COLLECTION:
        "Has the order been collected by the driver?",
    OrderStage.STAGE_4_ON_THE_ROAD: "Has the driver arrived at the Customer?",
    OrderStage.STAGE_5_ARRIVED: "Is the order delivered?",
    OrderStage.STAGE_6_WITH_CUSTOMER: "The order delivered",
    OrderStage.STAGE_7_ALL_PAID: "Completed"
  };

  static final currencyFormatter = NumberFormat("#,##0.00");

  static double? generateWaveNumber(int max) {
    var number;
    if (Random().nextBool()) {
      number = Random().nextDouble() >= 0.5 ? 0.8 : 0.4;
      return number;
    }
    number = Random().nextInt(max);
    return number > 0 ? number.toDouble() : generateWaveNumber(max);
  }

  static DateTime? dateFromJson(String? dateString) {
    if (dateString == null) return null;
    return DateTime.parse(dateString);
  }

  static String? dateToJson(DateTime? time) {
    if (time == null) return null;
    var date = DateTime.now();
    var pickupDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return pickupDate.toIso8601String();
  }

  static TimeOfDay timeOfDayFromJson(String dateString) {
    var date = DateTime.parse(dateString);
    return TimeOfDay.fromDateTime(date);
  }

  static String timeOfDayToJson(TimeOfDay time) {
    var date = DateTime.now();
    var pickupDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return pickupDate.toIso8601String();
  }

  static String pickUpDay(DateTime dateTime, BuildContext context) {
    var isToday = DateTime.now().day == dateTime.day;
    var isTomorrow = DateTime.now().day + 1 == dateTime.day;
    var timeOfDay = TimeOfDay.fromDateTime(dateTime);
    return isToday
        ? "Today at ${timeOfDay.format(context)}"
        : isTomorrow
            ? "Tomorrow at ${timeOfDay.format(context)}"
            : DateFormat("dd MMM yy 'at' HH:mm").format(dateTime);
  }

  static String openDay(DateTime dateTime, BuildContext context) {
    return DateFormat("HH:mm").format(dateTime);
  }

  static DateTime createPickUpDay(TimeOfDay time) {
    var date = DateTime.now();
    var pickupDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return pickupDate.isBefore(date)
        ? DateTime(date.year, date.month, date.day + 1, time.hour, time.minute)
        : pickupDate;
  }

  static void launchURLInCustomeTab(BuildContext context,
      {required String url}) async {
    try {
      await launch(
        url,
        customTabsOption: CustomTabsOption(
          toolbarColor: IjudiColors.color3,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsSystemAnimation.slideIn(),
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

  static double availableHeight(BuildContext context) =>
      (MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewInsets.bottom);

  static double calculationDialogMinHeight(BuildContext context) {
    var height = availableHeight(context);
    return height >= MediaQuery.of(context).size.height * 0.7
        ? height * 0.7
        : height;
  }

  static bool isValidSAId(String id) {
    if (id == null) {
      return false;
    }

    RegExp regex = RegExp(
        "(((\\d{2}((0[13578]|1[02])(0[1-9]|[12]\\d|3[01])|(0[13456789]|1[012])(0[1-9]|[12]\\d|30)|02(0[1-9]|1\\d|2[0-8])))|([02468][048]|[13579][26])0229))(( |-)(\\d{4})( |-)(\\d{3})|(\\d{7}))");

    if (!regex.hasMatch(id)) {
      return false;
    }

    int sum = 0;
    bool alternate = false;
    for (int i = id.length - 1; i >= 0; i--) {
      var n = int.tryParse(id.substring(i, i + 1));
      if (n == null) return false;
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n = (n % 10) + 1;
        }
      }
      sum += n;
      alternate = !alternate;
    }
    return (sum % 10 == 0);
  }

  static bool validSANumber(String? cellNumber) {
    RegExp reg = RegExp("((0))([0-9]{9})");
    return cellNumber != null &&
        cellNumber.length == 10 &&
        reg.hasMatch(cellNumber);
  }

  static bool isEmail(String name) {
    RegExp reg = RegExp(".+@.+\\..+");
    return name != null && reg.hasMatch(name);
  }

  static String formatToCurrency(double? value) {
    return value == null ? "None" : currencyFormatter.format(value);
  }

  static DateTime timeOfDayAsDateTime(TimeOfDay timeOfDay) {
    var today = DateTime.now();
    return DateTime(
        today.year, today.month, today.day, timeOfDay.hour, timeOfDay.minute);
  }

  static bool isSameDay(DateTime time1, DateTime time2) {
    return time1.year == time2.year &&
        time1.month == time2.month &&
        time1.day == time2.day;
  }
}
