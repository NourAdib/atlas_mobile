// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrapbook.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scrapbook _$ScrapbookFromJson(Map<String, dynamic> json) => Scrapbook(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      caption: json['caption'] as String?,
      type: json['type'] as String?,
      location: json['location'] as String?,
      visibility: $enumDecodeNullable(_$VisibilityEnumMap, json['visibility']),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScrapbookToJson(Scrapbook instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'caption': instance.caption,
      'type': instance.type,
      'location': instance.location,
      'visibility': _$VisibilityEnumMap[instance.visibility],
      'user': instance.user,
      'posts': instance.posts,
    };

const _$VisibilityEnumMap = {
  Visibility.public: 'public',
  Visibility.private: 'private',
};
