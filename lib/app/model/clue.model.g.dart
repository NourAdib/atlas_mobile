// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clue.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clue _$ClueFromJson(Map<String, dynamic> json) => Clue(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      text: json['text'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClueToJson(Clue instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'text': instance.text,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'event': instance.event,
    };
