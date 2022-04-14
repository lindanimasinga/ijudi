// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business-hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessHours _$BusinessHoursFromJson(Map<String, dynamic> json) =>
    BusinessHours(
      $enumDecode(_$DayEnumMap, json['day']),
      DateTime.parse(json['open'] as String),
      DateTime.parse(json['close'] as String),
    );

Map<String, dynamic> _$BusinessHoursToJson(BusinessHours instance) =>
    <String, dynamic>{
      'day': _$DayEnumMap[instance.day],
      'open': instance.open.toIso8601String(),
      'close': instance.close.toIso8601String(),
    };

const _$DayEnumMap = {
  Day.MONDAY: 'MONDAY',
  Day.TUESDAY: 'TUESDAY',
  Day.WEDNESDAY: 'WEDNESDAY',
  Day.THURSDAY: 'THURSDAY',
  Day.FRIDAY: 'FRIDAY',
  Day.SATURDAY: 'SATURDAY',
  Day.SUNDAY: 'SUNDAY',
};
