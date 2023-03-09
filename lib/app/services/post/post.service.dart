import 'dart:io';

import 'package:atlas_mobile/app/model/like.model.dart';
import 'package:atlas_mobile/app/model/meta.model.dart';
import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/scrapbook.model.dart';
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
  Future<UserPostsResponse> getUserPosts(
      @Header('Authorization') String token, @Query('page') int page);

  @GET('${Repo.postById}/{postId}')
  Future<Post> getPostById(
      @Header('Authorization') String token, @Path('postId') String postId);

  @GET(Repo.userScrapbooks)
  Future<UserScrapbookResponse> getUserScrapbooks(
      @Header('Authorization') String token, @Query('page') int page);

  @POST('${Repo.like}/{postId}')
  Future<Like> likePost(
      @Header('Authorization') String token, @Path('postId') String postId);

  @DELETE('${Repo.unlike}/{postId}')
  Future<Like> unlikePost(
      @Header('Authorization') String token, @Path('postId') String postId);

  @POST('${Repo.comment}/{postId}')
  Future<Post> commentPost(@Header('Authorization') String token,
      @Path('postId') String postId, @Body() CommentDto commentDto);
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

@JsonSerializable()
class UserScrapbookResponse {
  @JsonKey(name: 'data')
  List<Scrapbook>? scrapbooks;

  @JsonKey(name: 'meta')
  Meta? meta;

  UserScrapbookResponse({this.scrapbooks, this.meta});

  factory UserScrapbookResponse.fromJson(Map<String, dynamic> json) =>
      _$UserScrapbookResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserScrapbookResponseToJson(this);
}

@JsonSerializable()
class CommentDto {
  @JsonKey(name: 'text')
  String? text;

  CommentDto({this.text});

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}
