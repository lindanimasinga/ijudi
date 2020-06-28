
import 'package:json_annotation/json_annotation.dart';

part 'remote-message.g.dart';

@JsonSerializable(includeIfNull: false)
class RemoteMessage {
    
    MessageType messageType;
    dynamic messageContent;

    RemoteMessage();

    factory RemoteMessage.fromJson(Map<String, dynamic> json) => _$RemoteMessageFromJson(json);

    Map<String, dynamic> toJson() => _$RemoteMessageToJson(this);
}

enum MessageType {
  NEW_ORDER,
  MARKETING,
  PAYMENT,
  NEW_ORDER_UPDATE
}