// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business-hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessHours _$BusinessHoursFromJson(Map<String, dynamic> json) {
  return BusinessHours(
    _$enumDecodeNullable(_$DayEnumMap, json['day']),
    Utils.timeOfDayFromJson(json['open'] as String),
    Utils.timeOfDayFromJson(json['close'] as String),
  );
}

Map<String, dynamic> _$BusinessHoursToJson(BusinessHours instance) =>
    <String, dynamic>{
      'day': _$DayEnumMap[instance.day],
      'open': Utils.timeOfDayToJson(instance.open),
      'close': Utils.timeOfDayToJson(instance.close),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DayEnumMap = {
  Day.MONDAY: 'MONDAY',
  Day.TUESDAY: 'TUESDAY',
  Day.WEDNESDAY: 'WEDNESDAY',
  Day.THURSDAY: 'THURSDAY',
  Day.FRIDAY: 'FRIDAY',
  Day.SATURDAY: 'SATURDAY',
  Day.SUNDAY: 'SUNDAY',
};
