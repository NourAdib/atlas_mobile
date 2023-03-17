import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'user.model.dart';

part 'analytics.model.g.dart';

@JsonSerializable()
class PostAnalytics {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'commentCount')
  int? commentCount;
  @JsonKey(name: 'likeCount')
  int? likeCount;
  @JsonKey(name: 'interactionCount')
  int? interactionCount;
  @JsonKey(name: 'isTakenDown')
  bool? isTakenDown;
  @JsonKey(name: 'reportCount')
  int? reportCount;
  @JsonKey(name: 'appealCount')
  int? appealCount;
  @JsonKey(name: 'isPartOfScrapbook')
  bool? isPartOfScrapbook;
  @JsonKey(name: 'scrapbookId')
  String? scrapbookId;

  PostAnalytics({
    this.createdAt,
    this.commentCount,
    this.likeCount,
    this.interactionCount,
    this.isTakenDown,
    this.reportCount,
    this.appealCount,
    this.isPartOfScrapbook,
    this.scrapbookId,
  });

  factory PostAnalytics.fromJson(Map<String, dynamic> json) =>
      _$PostAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$PostAnalyticsToJson(this);
}
