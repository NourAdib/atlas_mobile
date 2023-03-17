import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'user.model.dart';

part 'appeal.model.g.dart';

@JsonSerializable()
class Appeal {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'reportReason')
  String? reportReason;
  @JsonKey(name: 'text')
  String? text;

  Appeal(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.status,
      this.reportReason,
      this.text});

  factory Appeal.fromJson(Map<String, dynamic> json) => _$AppealFromJson(json);
  Map<String, dynamic> toJson() => _$AppealToJson(this);
}
