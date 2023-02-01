import 'dart:io';

import 'package:atlas_mobile/app/model/meta.model.dart';
import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'post.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class PostService {
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  @GET(Repo.userPosts)
  Future<UserPostsResponse> getUserPosts(@Header('Authorization') String token);
}

@JsonSerializable()
class UserPostsResponse {
  @JsonKey(name: 'data')
  List<Post>? posts;

  @JsonKey(name: 'meta')
  Meta? meta;

  UserPostsResponse({this.posts, this.meta});

  factory UserPostsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPostsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserPostsResponseToJson(this);
}
