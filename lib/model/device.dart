import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable(includeIfNull: false)
class Device {
  
  final String token;
  String userId;

  var id;

  Device(this.token);

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}