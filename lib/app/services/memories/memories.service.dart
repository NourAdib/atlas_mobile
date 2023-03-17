import 'dart:developer';
import 'dart:io';

import 'package:atlas_mobile/app/model/meta.model.dart';
import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'memories.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class MemoriesService {
  factory MemoriesService(Dio dio, {String baseUrl}) = _MemoriesService;

  @POST('/memory/create')
  @MultiPart()
  Future<Memory> createMemory(
    @Header('Authorization') String token,
    @Part() String location,
    @Part() String visibility,
    @Part() String longitude,
    @Part() String latitude,
    @Part() File image,
  );

  @POST(Repo.memoriesPath)
  Future<MemoriesResponse> getMemories(
      @Header('Authorization') String token, @Body() MemoriesRequest request);

  @GET('${Repo.getMemoryById}/{id}}')
  Future<Memory> getMemoryById(
      @Header('Authorization') String token, @Path('id') String id);

  @GET(Repo.getUserMemories)
  Future<MemoriesResponse> getUserMemories(
      @Header('Authorization') String token, @Query('page') int page);

  @DELETE('/memory/{id}')
  Future<void> deleteMemory(
      @Header('Authorization') String token, @Path('id') String id);
}

@JsonSerializable()
class MemoriesRequest {
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;

  MemoriesRequest();
  factory MemoriesRequest.fromJson(Map<String, dynamic> json) =>
      _$MemoriesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MemoriesRequestToJson(this);
}

@JsonSerializable()
class MemoriesResponse {
  @JsonKey(name: 'data')
  List<Memory>? memories;

  @JsonKey(name: 'meta')
  Meta? meta;

  MemoriesResponse({this.memories, this.meta});

  factory MemoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$MemoriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemoriesResponseToJson(this);
}
