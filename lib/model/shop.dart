import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/stock.dart';
import 'package:json_annotation/json_annotation.dart';

import 'business-hours.dart';

part 'shop.g.dart';

@JsonSerializable(includeIfNull: false)
class Shop extends Profile {
  
  String registrationNumber;
  @JsonKey(toJson: listToJson)
  List<BusinessHours> businessHours;
  @JsonKey(toJson: listToJson)
  List<Stock> stockList;
  @JsonKey(toJson: listToJson)
  Set<String> tags;
  bool hasVat;
  String ownerId;

  Shop(
      {@required String id,
      @required String name,
      this.registrationNumber,
      this.stockList,
      this.hasVat = false,
      this.tags,
      @required String description,
      @required int yearsInService,
      @required String address,
      @required String imageUrl,
      int likes,
      @required int servicesCompleted,
      int badges,
      String verificationCode,
      @required String mobileNumber,
      @required String role,
      @required Bank bank})
      : super(
            id: id,
            name: name,
            description: description,
            yearsInService: yearsInService,
            address: address,
            imageUrl: imageUrl,
            likes: likes,
            servicesCompleted: servicesCompleted,
            badges: badges,
            mobileNumber: mobileNumber,
            verificationCode: verificationCode,
            role: role,
            bank: bank);

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);

  static List<Map<String,dynamic>> listToJson(Iterable<dynamic> list) {
    print("converting to json");
    var jsonString = list.map((f) => f.toJson())
      .toList();
    print(jsonString);
    return jsonString;  
  }
}
