// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_clue.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventClue _$EventClueFromJson(Map<String, dynamic> json) => EventClue(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      creator: json['creator'] == null
          ? null
          : User.fromJson(json['creator'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
    )..text = json['text'] as String?;

Map<String, dynamic> _$EventClueToJson(EventClue instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'text': instance.text,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'creator': instance.creator,
      'event': instance.event,
    };
