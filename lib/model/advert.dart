
import 'package:json_annotation/json_annotation.dart';

part 'advert.g.dart';

@JsonSerializable()
class Advert {

  String id;
  String imageUrl;
  String actionUrl;
  String shopId;
  String title;
  String message;

  Advert();

  factory Advert.fromJson(Map<String, dynamic> json) => _$AdvertFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertToJson(this);
}