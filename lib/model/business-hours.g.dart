// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business-hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessHours _$BusinessHoursFromJson(Map<String, dynamic> json) {
  return BusinessHours(
    _$enumDecodeNullable(_$DayEnumMap, json['day']),
    json['open'] == null ? null : DateTime.parse(json['open'] as String),
    json['close'] == null ? null : DateTime.parse(json['close'] as String),
  );
}

Map<String, dynamic> _$BusinessHoursToJson(BusinessHours instance) =>
    <String, dynamic>{
      'day': _$DayEnumMap[instance.day],
      'open': instance.open?.toIso8601String(),
      'close': instance.close?.toIso8601String(),
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
