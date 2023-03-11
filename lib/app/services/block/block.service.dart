import 'dart:io';

import 'package:atlas_mobile/app/model/block.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'block.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class BlockService {
  factory BlockService(Dio dio, {String baseUrl}) = _BlockService;

  @POST('${Repo.blockUser}/{userId}')
  Future<Block> blockUser(
      @Header('Authorization') String token, @Path('userId') String userId);

  @POST('${Repo.unblockUser}/{userId}')
  Future<UnblockUserResponse> unblockUser(
      @Header('Authorization') String token, @Path('userId') String userId);
}

@JsonSerializable()
class UnblockUserResponse {
  @JsonKey(name: 'message')
  String? message;

  UnblockUserResponse({this.message});

  factory UnblockUserResponse.fromJson(Map<String, dynamic> json) =>
      _$UnblockUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UnblockUserResponseToJson(this);
}
