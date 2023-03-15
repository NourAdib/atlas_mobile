import 'dart:io';

import 'package:atlas_mobile/app/model/enums/visibility.enum.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'clue.model.dart';
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
  @JsonKey(name: 'numberOfParticipants')
  int? numberOfParticipants;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'visibility')
  Visibility? visibility;
  @JsonKey(name: 'date')
  DateTime? date;
  @JsonKey(name: 'clues')
  List<Clue>? clues;
  @JsonKey(name: 'goal')
  Clue? goal;
  @JsonKey(name: 'creator')
  User? creator;
  @JsonKey(name: 'participants')
  List<User>? participants;

  Event(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.description,
      this.numberOfParticipants,
      this.latitude,
      this.longitude,
      this.visibility,
      this.date,
      this.clues,
      this.goal,
      this.creator});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
