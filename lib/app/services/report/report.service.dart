import 'package:atlas_mobile/app/model/post_report.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'report.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class ReportService {
  factory ReportService(Dio dio, {String baseUrl}) = _ReportService;

  @POST(Repo.reportPost)
  Future<PostReport> reportPost(
      @Header('Authorization') String token, @Body() ReportDto reportPostDto);

  @POST(Repo.reportUser)
  Future<PostReport> reportUser(
      @Header('Authorization') String token, @Body() ReportDto reportPostDto);
}

@JsonSerializable()
class ReportDto {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'reason')
  String? reason;

  ReportDto({this.id, this.reason});

  factory ReportDto.fromJson(Map<String, dynamic> json) =>
      _$ReportDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReportDtoToJson(this);
}
