
import 'package:json_annotation/json_annotation.dart';

part 'cards-on-file.g.dart';

@JsonSerializable()
class CardsOnFile {
  
  final String alias;
  final String tokenKey;
  final String last4Digits;

  CardsOnFile(this.alias, this.tokenKey, this.last4Digits);

  factory CardsOnFile.fromJson(Map<String, dynamic> json) => _$CardsOnFileFromJson(json);
}