// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      visibility: $enumDecodeNullable(_$VisibilityEnumMap, json['visibility']),
      numberOfParticipants: json['numberOfParticipants'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      creator: json['creator'] == null
          ? null
          : User.fromJson(json['creator'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      goal: json['goal'] == null
          ? null
          : EventGoal.fromJson(json['goal'] as Map<String, dynamic>),
      clues: (json['clues'] as List<dynamic>?)
          ?.map((e) => EventClue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'visibility': _$VisibilityEnumMap[instance.visibility],
      'numberOfParticipants': instance.numberOfParticipants,
      'date': instance.date?.toIso8601String(),
      'creator': instance.creator,
      'participants': instance.participants,
      'goal': instance.goal,
      'clues': instance.clues,
    };

const _$VisibilityEnumMap = {
  Visibility.public: 'public',
  Visibility.private: 'private',
};
