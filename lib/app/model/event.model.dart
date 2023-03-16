import 'dart:io';

import 'package:atlas_mobile/app/model/enums/visibility.enum.dart';
import 'package:atlas_mobile/app/model/event_goal.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'event_clue.model.dart';
import 'user.model.dart';

part 'event.model.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'visibility')
  Visibility? visibility;
  @JsonKey(name: 'numberOfParticipants')
  int? numberOfParticipants;
  @JsonKey(name: 'date')
  DateTime? date;
  @JsonKey(name: 'creator')
  User? creator;
  @JsonKey(name: 'participants')
  List<User>? participants;
  @JsonKey(name: 'goal')
  EventGoal? goal;
  @JsonKey(name: 'clues')
  List<EventClue>? clues;

  Event(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.description,
      this.latitude,
      this.longitude,
      this.visibility,
      this.numberOfParticipants,
      this.date,
      this.creator,
      this.participants,
      this.goal,
      this.clues});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
