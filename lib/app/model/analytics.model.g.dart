// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAnalytics _$PostAnalyticsFromJson(Map<String, dynamic> json) =>
    PostAnalytics(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      commentCount: json['commentCount'] as int?,
      likeCount: json['likeCount'] as int?,
      interactionCount: json['interactionCount'] as int?,
      isTakenDown: json['isTakenDown'] as bool?,
      reportCount: json['reportCount'] as int?,
      appealCount: json['appealCount'] as int?,
      isPartOfScrapbook: json['isPartOfScrapbook'] as bool?,
      scrapbookId: json['scrapbookId'] as String?,
    );

Map<String, dynamic> _$PostAnalyticsToJson(PostAnalytics instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'interactionCount': instance.interactionCount,
      'isTakenDown': instance.isTakenDown,
      'reportCount': instance.reportCount,
      'appealCount': instance.appealCount,
      'isPartOfScrapbook': instance.isPartOfScrapbook,
      'scrapbookId': instance.scrapbookId,
    };
