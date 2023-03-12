// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      blockingUser: json['blockingUser'] == null
          ? null
          : User.fromJson(json['blockingUser'] as Map<String, dynamic>),
      blockedUser: json['blockedUser'] == null
          ? null
          : User.fromJson(json['blockedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'blockingUser': instance.blockingUser,
      'blockedUser': instance.blockedUser,
    };
