import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'user.model.dart';

part 'follow_request.model.g.dart';

@JsonSerializable()
class FollowRequest {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'requestedBy')
  User? requestedBy;
  @JsonKey(name: 'requestedUser')
  User? requestedUser;

  FollowRequest(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.status,
      this.requestedBy,
      this.requestedUser});

  factory FollowRequest.fromJson(Map<String, dynamic> json) =>
      _$FollowRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FollowRequestToJson(this);
}
