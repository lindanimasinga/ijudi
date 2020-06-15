import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userProfile.g.dart';

@JsonSerializable(includeIfNull: false)
class UserProfile extends Profile {
  
  String idNumber;

  UserProfile(
      {
      @required String id,
      @required String name,
      @required this.idNumber,
      @required String description,
      int yearsInService,
      String address,
      @required String imageUrl,
      int likes,
      int servicesCompleted,
      int badges,
      String verificationCode,
      @required String mobileNumber,
      @required ProfileRoles role,
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

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this); 

}
