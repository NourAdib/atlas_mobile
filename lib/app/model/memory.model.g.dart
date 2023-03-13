// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Memory _$MemoryFromJson(Map<String, dynamic> json) => Memory(
      imageUrl: json['imageUrl'] as String?,
      imageId: json['imageId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      location: json['location'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      visibility: $enumDecodeNullable(_$VisibilityEnumMap, json['visibility']),
      imageExpiryDate: json['imageExpiryDate'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemoryToJson(Memory instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'imageId': instance.imageId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'visibility': _$VisibilityEnumMap[instance.visibility],
      'imageExpiryDate': instance.imageExpiryDate,
      'user': instance.user,
    };

const _$VisibilityEnumMap = {
  Visibility.public: 'public',
  Visibility.private: 'private',
};
