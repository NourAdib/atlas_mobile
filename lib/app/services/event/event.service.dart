import 'dart:developer';
import 'dart:io';

import 'package:atlas_mobile/app/model/meta.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../model/event.model.dart';

part 'event.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class EventsService {
  factory EventsService(Dio dio, {String baseUrl}) = _EventsService;

  @POST('/event/create-event')
  Future<Event> createEvent(
      @Header('Authorization') String token, @Body() CreateEventDto request);

  @POST(Repo.proximityEvents)
  Future<List<Event>> getProximityEvents(@Header('Authorization') String token,
      @Body() ProximityEventsRequest request);

  @GET(Repo.getUserEvents)
  Future<EventsResponse> getUserEvents(
      @Header('Authorization') String token, @Query('page') int page);

  @GET('${Repo.getEventById}/{id}')
  Future<Event> getEventById(
      @Header('Authorization') String token, @Path('id') String id);

  @GET(Repo.getJoinedEvents)
  Future<EventsResponse> getJoinedEvents(
      @Header('Authorization') String token, @Query('page') int page);

  @POST('${Repo.joinEvent}/{id}')
  Future<Event> joinEvent(
      @Header('Authorization') String token, @Path('id') String id);

  @DELETE('/event/{id}')
  Future<Response> deleteEvent(
      @Header('Authorization') String token, @Path('id') String id);
}

@JsonSerializable()
class EventsResponse {
  @JsonKey(name: 'data')
  List<Event>? events;

  @JsonKey(name: 'meta')
  Meta? meta;

  EventsResponse({this.events, this.meta});

  factory EventsResponse.fromJson(Map<String, dynamic> json) =>
      _$EventsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EventsResponseToJson(this);
}

@JsonSerializable()
class Response {
  @JsonKey(name: 'message')
  String? message;

  Response({this.message});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class ProximityEventsRequest {
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;

  ProximityEventsRequest();
  factory ProximityEventsRequest.fromJson(Map<String, dynamic> json) =>
      _$ProximityEventsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProximityEventsRequestToJson(this);
}

@JsonSerializable()
class CreateEventDto {
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'numberOfParticipants')
  int? numberOfParticipants;
  @JsonKey(name: 'visibility')
  String? visibility;
  @JsonKey(name: 'date')
  DateTime? date;
  @JsonKey(name: 'goal')
  GoalDto? goal;
  @JsonKey(name: 'clues')
  List<ClueDto>? clues;

  CreateEventDto();
  factory CreateEventDto.fromJson(Map<String, dynamic> json) =>
      _$CreateEventDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateEventDtoToJson(this);
}

@JsonSerializable()
class GoalDto {
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'text')
  String? text;

  GoalDto();
  factory GoalDto.fromJson(Map<String, dynamic> json) =>
      _$GoalDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GoalDtoToJson(this);
}

@JsonSerializable()
class ClueDto {
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'text')
  String? text;

  ClueDto();
  factory ClueDto.fromJson(Map<String, dynamic> json) =>
      _$ClueDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ClueDtoToJson(this);
}
