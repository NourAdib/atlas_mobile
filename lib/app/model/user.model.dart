import 'dart:io';

import 'package:atlas_mobile/app/model/enums/gender.enum.dart';
import 'package:atlas_mobile/app/model/enums/notificationPreference.enum.dart';
import 'package:atlas_mobile/app/model/enums/role.enum.dart';
import 'package:atlas_mobile/app/model/enums/subscription.enum.dart';
import 'package:atlas_mobile/app/model/enums/visibility.enum.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user.model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'profilePictureUrl')
  String? profilePictureUrl;
  @JsonKey(name: 'profilePictureId')
  String? profilePictureId;
  @JsonKey(name: 'gender')
  Gender? gender;
  @JsonKey(name: 'fcmToken')
  String? fcmToken;
  @JsonKey(name: 'notificationPreference')
  NotificationPreference? notificationPreference;
  @JsonKey(name: 'isBanned')
  bool? isBanned;
  @JsonKey(name: 'hasStripAccount')
  bool? hasStripAccount;
  @JsonKey(name: 'stripeCustomerId')
  String? stripeCustomerId;
  @JsonKey(name: 'subscriptionPlan')
  SubscriptionPlan? subscriptionPlan;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'dateOfBirth')
  String? dateOfBirth;
  @JsonKey(name: 'role')
  Role? role;
  @JsonKey(name: 'profilePictureExpiryDate')
  String? profilePictureExpiryDate;
  @JsonKey(name: 'followersCount')
  int? followersCount;
  @JsonKey(name: 'followingCount')
  int? followingCount;
  @JsonKey(name: 'bio')
  String? bio;

  User({
    this.address,
    this.profilePictureUrl,
    this.profilePictureId,
    this.gender,
    this.fcmToken,
    this.notificationPreference,
    this.isBanned,
    this.hasStripAccount,
    this.stripeCustomerId,
    this.subscriptionPlan,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phoneNumber,
    this.dateOfBirth,
    this.role,
    this.profilePictureExpiryDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
