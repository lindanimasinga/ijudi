import 'package:json_annotation/json_annotation.dart';

part 'customer-status.g.dart';

@JsonSerializable()
class CustomerStatus {
  bool enabled;
  bool locked;
  bool selfieMatchesIdentity = true;
  bool selfieIsASelfie = true;
  bool nameMatchesIdentity = true;
  bool identityNumberMatchesIdentity = true;

  CustomerStatus();

  bool get complianceChecksAllPassed =>
      selfieMatchesIdentity &&
      nameMatchesIdentity &&
      identityNumberMatchesIdentity &&
      selfieIsASelfie;

  factory CustomerStatus.fromJson(Map<String, dynamic> json) =>
      _$CustomerStatusFromJson(json);
}
