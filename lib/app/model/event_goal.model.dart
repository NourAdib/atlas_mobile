import 'dart:io';

import 'package:atlas_mobile/app/model/enums/visibility.enum.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'event.model.dart';
import 'user.model.dart';

part 'event_goal.model.g.dart';

@JsonSerializable()
class EventGoal {
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
  @JsonKey(name: 'creator')
  User? creator;
  @JsonKey(name: 'event')
  Event? event;

  EventGoal(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.latitude,
      this.longitude,
      this.creator,
      this.event});

  factory EventGoal.fromJson(Map<String, dynamic> json) =>
      _$EventGoalFromJson(json);
  Map<String, dynamic> toJson() => _$EventGoalToJson(this);
}
