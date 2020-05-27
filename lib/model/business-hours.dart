import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'day.dart';

part 'business-hours.g.dart';

@JsonSerializable()
class BusinessHours {

  final Day day;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final TimeOfDay open;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final TimeOfDay close;

  BusinessHours(this.day, this.open, this.close);

  factory BusinessHours.fromJson(Map<String, dynamic> json) => _$BusinessHoursFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessHoursToJson(this);

  static TimeOfDay dateFromJson(String dateString) {
    var date = DateTime.parse(dateString).toLocal();
    return TimeOfDay.fromDateTime(date);
  }

  static String dateToJson(TimeOfDay time) {
    var date =DateTime.now();
    var pickupDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return json.encode(pickupDate);
  }
}