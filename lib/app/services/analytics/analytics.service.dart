import 'package:atlas_mobile/app/model/analytics.model.dart';
import 'package:atlas_mobile/app/model/appeal.model.dart';
import 'package:atlas_mobile/app/model/meta.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'analytics.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class AnalyticsService {
  factory AnalyticsService(Dio dio, {String baseUrl}) = _AnalyticsService;

  @GET('${Repo.analytics}/{id}')
  Future<PostAnalytics> getPostAnalytics(
      @Header('Authorization') String token, @Path('id') String postId);
}
