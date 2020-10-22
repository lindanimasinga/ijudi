// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer-status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerStatus _$CustomerStatusFromJson(Map<String, dynamic> json) {
  return CustomerStatus()
    ..enabled = json['enabled'] as bool
    ..locked = json['locked'] as bool
    ..selfieMatchesIdentity = json['selfieMatchesIdentity'] as bool
    ..selfieIsASelfie = json['selfieIsASelfie'] as bool
    ..nameMatchesIdentity = json['nameMatchesIdentity'] as bool
    ..identityNumberMatchesIdentity =
        json['identityNumberMatchesIdentity'] as bool;
}

Map<String, dynamic> _$CustomerStatusToJson(CustomerStatus instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'locked': instance.locked,
      'selfieMatchesIdentity': instance.selfieMatchesIdentity,
      'selfieIsASelfie': instance.selfieIsASelfie,
      'nameMatchesIdentity': instance.nameMatchesIdentity,
      'identityNumberMatchesIdentity': instance.identityNumberMatchesIdentity,
    };
