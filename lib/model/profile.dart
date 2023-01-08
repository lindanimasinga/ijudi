import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

abstract class Profile {
  String? id;
  String? name;
  String? description;
  int? yearsInService;
  String? address;
  String? imageUrl;
  int? likes;
  int? servicesCompleted;
  int? badges;
  String? mobileNumber;
  String? emailAddress;
  ProfileRoles? role;
  int? responseTimeMinutes;
  String? verificationCode;
  Bank? bank = Bank();
  ProfileAvailabilityStatus? availabilityStatus;

  Profile(
      {required this.name,
      required this.description,
      required this.yearsInService,
      required this.address,
      required this.imageUrl,
      this.likes,
      this.servicesCompleted,
      this.badges,
      this.verificationCode,
      required this.mobileNumber,
      required this.role,
      required this.id,
      required this.bank,
      this.availabilityStatus});
}

@JsonSerializable(includeIfNull: false)
class Bank {
  String? name;
  String? phone;
  String? accountId;
  BankAccType? type;
  String? branchCode;
  int? customerId;
  double? currentBalance = 0;
  double? availableBalance = 0;
  String? idNumber;

  Bank(
      {this.name,
      this.idNumber,
      this.accountId = "- - -",
      this.type,
      this.currentBalance = 0,
      this.availableBalance = 0,
      this.phone = "- - -",
      this.customerId});

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
}

enum ProfileRoles { CUSTOMER, STORE_ADMIN, STORE, MESSENGER, ADMIN }

enum BankAccType { CHEQUE, EWALLET, SAVINGS, TRANSMISSION }

enum ProfileAvailabilityStatus { ONLINE, OFFLINE, AWAY }
