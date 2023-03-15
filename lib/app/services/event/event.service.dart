import 'dart:developer';
import 'dart:io';

import 'package:atlas_mobile/app/model/event.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'event.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class EventsService {
  factory EventsService(Dio dio, {String baseUrl}) = _EventsService;

  @POST(Repo.proximityEvents)
  Future<List<Event>> getProximityEvents(@Header('Authorization') String token,
      @Body() ProximityEventsRequest request);

  @DELETE("/event/{id}")
  Future<void> deleteEvent(
      @Header('Authorization') String token, @Path('id') String id);

  @POST("/event/join-event/{id}")
  Future<void> joinEvent(
      @Header('Authorization') String token, @Path('id') String id);
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
