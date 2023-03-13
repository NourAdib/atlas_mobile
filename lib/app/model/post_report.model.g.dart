// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_report.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostReport _$PostReportFromJson(Map<String, dynamic> json) => PostReport(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String?,
      reportedBy: json['reportedBy'] == null
          ? null
          : User.fromJson(json['reportedBy'] as Map<String, dynamic>),
      reason: json['reason'] as String?,
      reportedPost: json['reportedPost'] == null
          ? null
          : Post.fromJson(json['reportedPost'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostReportToJson(PostReport instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'reason': instance.reason,
      'reportedPost': instance.reportedPost,
      'reportedBy': instance.reportedBy,
    };
