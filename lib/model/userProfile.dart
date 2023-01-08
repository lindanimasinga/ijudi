import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';

import 'geo-location.dart';

part 'userProfile.g.dart';

@JsonSerializable(includeIfNull: false)
class UserProfile extends Profile with GeoLocation {
  String? idNumber;
  SignUpReason? signUpReason;

  UserProfile.empty()
      : super(
            id: "id",
            name: "name",
            description: "description",
            yearsInService: 20,
            address: "address",
            imageUrl: "imageUrl",
            likes: 0,
            servicesCompleted: 0,
            badges: 0,
            mobileNumber: "mobileNumber",
            verificationCode: "verificationCode",
            role: ProfileRoles.MESSENGER,
            bank: Bank());

  UserProfile(
      {String? id,
      required String? name,
      SignUpReason? signUpReason,
      this.idNumber,
      required String? description,
      int? yearsInService,
      String? address,
      required String? imageUrl,
      int? likes,
      int? servicesCompleted,
      int? badges,
      double? latitude,
      double? longitude,
      String? verificationCode,
      required String? mobileNumber,
      required ProfileRoles? role,
      Bank? bank,
      ProfileAvailabilityStatus? availabilityStatus,
      String? surname})
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
            availabilityStatus: availabilityStatus,
            role: role,
            bank: bank);

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

enum SignUpReason { DELIVERY_DRIVER, SELL, BUY }
