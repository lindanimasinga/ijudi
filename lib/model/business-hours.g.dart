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

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
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
