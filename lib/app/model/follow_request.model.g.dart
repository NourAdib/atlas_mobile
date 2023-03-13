// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowRequest _$FollowRequestFromJson(Map<String, dynamic> json) =>
    FollowRequest(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      status: json['status'] as String?,
      requestedBy: json['requestedBy'] == null
          ? null
          : User.fromJson(json['requestedBy'] as Map<String, dynamic>),
      requestedUser: json['requestedUser'] == null
          ? null
          : User.fromJson(json['requestedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowRequestToJson(FollowRequest instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'status': instance.status,
      'requestedBy': instance.requestedBy,
      'requestedUser': instance.requestedUser,
    };
