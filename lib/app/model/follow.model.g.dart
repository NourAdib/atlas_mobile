// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follow _$FollowFromJson(Map<String, dynamic> json) => Follow(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      followedBy: json['followedBy'] == null
          ? null
          : User.fromJson(json['followedBy'] as Map<String, dynamic>),
      followed: json['followed'] == null
          ? null
          : User.fromJson(json['followed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowToJson(Follow instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'followedBy': instance.followedBy,
      'followed': instance.followed,
    };
