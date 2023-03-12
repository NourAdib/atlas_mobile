import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'enums/reportReasons.enum.dart';
import 'post.model.dart';
import 'user.model.dart';

part 'post_report.model.g.dart';

@JsonSerializable()
class PostReport {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'reason')
  String? reason;
  @JsonKey(name: 'reportedPost')
  Post? reportedPost;
  @JsonKey(name: 'reportedBy')
  User? reportedBy;

  PostReport({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.reportedBy,
    this.reason,
    this.reportedPost,
  });

  factory PostReport.fromJson(Map<String, dynamic> json) =>
      _$PostReportFromJson(json);
  Map<String, dynamic> toJson() => _$PostReportToJson(this);
}
