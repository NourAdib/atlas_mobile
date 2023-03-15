import 'dart:io';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'event.model.dart';

part 'clue.model.g.dart';

@JsonSerializable()
class Clue {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'text')
  String? text;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'event')
  Event? event;

  Clue(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.text,
      this.latitude,
      this.longitude,
      this.event});

  factory Clue.fromJson(Map<String, dynamic> json) => _$ClueFromJson(json);
  Map<String, dynamic> toJson() => _$ClueToJson(this);
}
