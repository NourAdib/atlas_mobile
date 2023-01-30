// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      isTakenDown: json['isTakenDown'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      imageId: json['imageId'] as String?,
      likesCount: json['likesCount'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      caption: json['caption'] as String?,
      tag: json['tag'] as String?,
      type: json['type'] as String?,
      location: json['location'] as String?,
      visibility: $enumDecodeNullable(_$VisibilityEnumMap, json['visibility']),
      imageExpiryDate: json['imageExpiryDate'] as String?,
      postedBy: json['postedBy'] == null
          ? null
          : User.fromJson(json['postedBy'] as Map<String, dynamic>),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'isTakenDown': instance.isTakenDown,
      'imageUrl': instance.imageUrl,
      'imageId': instance.imageId,
      'likesCount': instance.likesCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'caption': instance.caption,
      'tag': instance.tag,
      'type': instance.type,
      'location': instance.location,
      'visibility': _$VisibilityEnumMap[instance.visibility],
      'imageExpiryDate': instance.imageExpiryDate,
      'postedBy': instance.postedBy,
      'likes': instance.likes,
      'comments': instance.comments,
    };

const _$VisibilityEnumMap = {
  Visibility.public: 'public',
  Visibility.private: 'private',
};
