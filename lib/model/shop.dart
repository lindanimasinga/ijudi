import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable(includeIfNull: false)
class Shop extends Profile {
  String registrationNumber;

  Shop(
      {@required String id,
      @required String name,
      this.registrationNumber,
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
}
