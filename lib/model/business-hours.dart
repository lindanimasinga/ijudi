
import 'package:flutter/material.dart';
import 'package:ijudi/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'day.dart';

part 'business-hours.g.dart';

@JsonSerializable()
class BusinessHours {

  final Day day;
  @JsonKey(ignore: false,fromJson: Utils.timeOfDayFromJson, toJson: Utils.timeOfDayToJson)
  final TimeOfDay open;
  @JsonKey(ignore: false, fromJson: Utils.timeOfDayFromJson, toJson: Utils.timeOfDayToJson)
  final TimeOfDay close;

  BusinessHours(this.day, this.open, this.close);

  factory BusinessHours.fromJson(Map<String, dynamic> json) => _$BusinessHoursFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessHoursToJson(this);

}