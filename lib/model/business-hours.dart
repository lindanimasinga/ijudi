import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/util/util.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'day.dart';

part 'business-hours.g.dart';

@JsonSerializable()
class BusinessHours {

  final Day day;
  @JsonKey(ignore: false,fromJson: Utils.timeOfDayFromJson, toJson: Utils.timeOfDayToJson)
  final TimeOfDay open;
  @JsonKey(ignore: false, fromJson: dateFromJson, toJson: dateToJson)
  final TimeOfDay close;

  BusinessHours(this.day, this.open, this.close);

  factory BusinessHours.fromJson(Map<String, dynamic> json) => _$BusinessHoursFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessHoursToJson(this);

  static TimeOfDay dateFromJson(String dateString) {
    var date = DateTime.parse(dateString).toLocal();
    return TimeOfDay.fromDateTime(date);
  }

  static String dateToJson(TimeOfDay time) {
    log("converting $time");
    var date =DateTime.now();
    var pickupDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    log("converting $time passed");
    return new DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(pickupDate);
  }

  
}