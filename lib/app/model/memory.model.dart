import 'dart:io';

import 'package:atlas_mobile/app/model/enums/visibility.enum.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'user.model.dart';

part 'memory.model.g.dart';

@JsonSerializable()
class Memory {
  @JsonKey(name: 'imageUrl')
  String? imageUrl;
  @JsonKey(name: 'imageId')
  String? imageId;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'visibility')
  Visibility? visibility;
  @JsonKey(name: 'imageExpiryDate')
  String? imageExpiryDate;
  @JsonKey(name: 'user')
  User? user;

  Memory(
      {this.imageUrl,
      this.imageId,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.location,
      this.latitude,
      this.longitude,
      this.visibility,
      this.imageExpiryDate,
      this.user});

  factory Memory.fromJson(Map<String, dynamic> json) => _$MemoryFromJson(json);
  Map<String, dynamic> toJson() => _$MemoryToJson(this);
}
