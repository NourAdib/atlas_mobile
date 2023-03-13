// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appeal _$AppealFromJson(Map<String, dynamic> json) => Appeal(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      status: json['status'] as String?,
      reportReason: json['reportReason'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$AppealToJson(Appeal instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'status': instance.status,
      'reportReason': instance.reportReason,
      'text': instance.text,
    };
