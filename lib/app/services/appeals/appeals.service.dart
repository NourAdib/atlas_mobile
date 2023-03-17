import 'package:atlas_mobile/app/model/appeal.model.dart';
import 'package:atlas_mobile/app/model/meta.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'appeals.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class AppealsService {
  factory AppealsService(Dio dio, {String baseUrl}) = _AppealsService;

  @POST(Repo.appealPost)
  Future<Appeal> appealPost(
      @Header('Authorization') String token, @Body() AppealDto appealDto);

  @GET(Repo.getUserAppeals)
  Future<AppealsResponse> getUserAppeals(
      @Header('Authorization') String token, @Query('page') int page);
}

@JsonSerializable()
class AppealDto {
  @JsonKey(name: 'postId')
  String? postId;

  @JsonKey(name: 'text')
  String? text;

  AppealDto({this.postId, this.text});

  factory AppealDto.fromJson(Map<String, dynamic> json) =>
      _$AppealDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AppealDtoToJson(this);
}

@JsonSerializable()
class AppealsResponse {
  @JsonKey(name: 'data')
  List<Appeal>? appeals;

  @JsonKey(name: 'meta')
  Meta? meta;

  AppealsResponse({this.appeals, this.meta});

  factory AppealsResponse.fromJson(Map<String, dynamic> json) =>
      _$AppealsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppealsResponseToJson(this);
}
