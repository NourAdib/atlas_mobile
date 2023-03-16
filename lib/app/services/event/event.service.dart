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
