import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'user.model.dart';

part 'block.model.g.dart';

@JsonSerializable()
class Block {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'blockingUser')
  User? blockingUser;
  @JsonKey(name: 'blockedUser')
  User? blockedUser;

  Block(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.blockingUser,
      this.blockedUser});

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
  Map<String, dynamic> toJson() => _$BlockToJson(this);
}
