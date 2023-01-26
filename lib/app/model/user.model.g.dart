// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      address: json['address'] as bool?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      profilePictureId: json['profilePictureId'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      fcmToken: json['fcmToken'] as String?,
      notificationPreference: $enumDecodeNullable(
          _$NotificationPreferenceEnumMap, json['notificationPreference']),
      isBanned: json['isBanned'] as bool?,
      hasStripAccount: json['hasStripAccount'] as bool?,
      stripeCustomerId: json['stripeCustomerId'] as String?,
      subscriptionPlan: $enumDecodeNullable(
          _$SubscriptionPlanEnumMap, json['subscriptionPlan']),
      createdAt: json['createdAt'] as String?,
      updatedAt: $enumDecodeNullable(_$VisibilityEnumMap, json['updatedAt']),
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      profilePictureExpiryDate: json['profilePictureExpiryDate'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'address': instance.address,
      'profilePictureUrl': instance.profilePictureUrl,
      'profilePictureId': instance.profilePictureId,
      'gender': _$GenderEnumMap[instance.gender],
      'fcmToken': instance.fcmToken,
      'notificationPreference':
          _$NotificationPreferenceEnumMap[instance.notificationPreference],
      'isBanned': instance.isBanned,
      'hasStripAccount': instance.hasStripAccount,
      'stripeCustomerId': instance.stripeCustomerId,
      'subscriptionPlan': _$SubscriptionPlanEnumMap[instance.subscriptionPlan],
      'createdAt': instance.createdAt,
      'updatedAt': _$VisibilityEnumMap[instance.updatedAt],
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'role': _$RoleEnumMap[instance.role],
      'profilePictureExpiryDate': instance.profilePictureExpiryDate,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
  Gender.undefined: 'undefined',
};

const _$NotificationPreferenceEnumMap = {
  NotificationPreference.all: 'all',
  NotificationPreference.none: 'none',
  NotificationPreference.selectedGroup: 'selectedGroup',
  NotificationPreference.broadcast: 'broadcast',
};

const _$SubscriptionPlanEnumMap = {
  SubscriptionPlan.basic: 'basic',
  SubscriptionPlan.premium: 'premium',
};

const _$VisibilityEnumMap = {
  Visibility.public: 'public',
  Visibility.private: 'private',
};

const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.standard: 'standard',
  Role.celebrity: 'celebrity',
  Role.influencer: 'influencer',
  Role.professional: 'professional',
};
