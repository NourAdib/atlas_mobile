import 'dart:developer';
import 'dart:io';

import 'package:atlas_mobile/app/model/clue.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'clue.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class CluesService {
  factory CluesService(Dio dio, {String baseUrl}) = _CluesService;

  @POST(Repo.proximityClues)
  Future<List<Clue>> getProximityClues(@Header('Authorization') String token,
      @Body() ProximityCluesRequest request);
}

@JsonSerializable()
class ProximityCluesRequest {
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;

  ProximityCluesRequest();
  factory ProximityCluesRequest.fromJson(Map<String, dynamic> json) =>
      _$ProximityCluesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProximityCluesRequestToJson(this);
}
