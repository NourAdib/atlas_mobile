import 'dart:io';

import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'feed.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class FeedService {
  factory FeedService(Dio dio, {String baseUrl}) = _FeedService;

  @GET(Repo.feedPath)
  Future<FeedResponse> getFeed(
      @Header('Authorization') String token, @Query('page') int page);
}

@JsonSerializable()
class FeedResponse {
  @JsonKey(name: 'data')
  List<Post>? posts;

  @JsonKey(name: 'meta')
  Meta? meta;

  FeedResponse({this.posts, this.meta});

  factory FeedResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedResponseToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'take')
  int? take;
  @JsonKey(name: 'itemCount')
  int? itemCount;
  @JsonKey(name: 'pageCount')
  int? pageCount;
  @JsonKey(name: 'hasPreviousPage')
  bool? hasPreviousPage;
  @JsonKey(name: 'hasNextPage')
  bool? hasNextPage;

  Meta(
      {this.page,
      this.take,
      this.itemCount,
      this.pageCount,
      this.hasPreviousPage,
      this.hasNextPage});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
