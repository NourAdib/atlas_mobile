import 'dart:io';

import 'package:atlas_mobile/app/model/enums/reportReasons.enum.dart';
import 'package:atlas_mobile/app/model/like.model.dart';
import 'package:atlas_mobile/app/model/meta.model.dart';
import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/post_report.model.dart';
import 'package:atlas_mobile/app/model/scrapbook.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
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
  Future<PostReport> reportPost(@Header('Authorization') String token,
      @Body() ReportPostDto reportPostDto);
}

@JsonSerializable()
class ReportPostDto {
  @JsonKey(name: 'id')
  String? postId;

  @JsonKey(name: 'reason')
  String? reason;

  ReportPostDto({this.postId, this.reason});

  factory ReportPostDto.fromJson(Map<String, dynamic> json) =>
      _$ReportPostDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReportPostDtoToJson(this);
}
