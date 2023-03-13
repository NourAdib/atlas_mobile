import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'user.model.dart';

part 'follow.model.g.dart';

@JsonSerializable()
class Follow {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'followedBy')
  User? followedBy;
  @JsonKey(name: 'followed')
  User? followed;

  Follow(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.followedBy,
      this.followed});

  factory Follow.fromJson(Map<String, dynamic> json) => _$FollowFromJson(json);
  Map<String, dynamic> toJson() => _$FollowToJson(this);
}
