import 'package:atlas_mobile/app/model/follow.model.dart';
import 'package:atlas_mobile/app/model/follow_request.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../model/meta.model.dart';

part 'follow.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class FollowService {
  factory FollowService(Dio dio, {String baseUrl}) = _FollowService;

  @POST('${Repo.requestFollow}/{userId}')
  Future<FollowRequest> requestFollow(
      @Header('Authorization') String token, @Path('userId') String userId);

  @PATCH('${Repo.acceptFollow}/{requestId}')
  Future<Follow> acceptFollowRequest(@Header('Authorization') String token,
      @Path('requestId') String requestId);

  @PATCH('${Repo.rejectFollow}/{requestId}')
  Future<RejectFollowResponse> rejectFollowRequest(
      @Header('Authorization') String token,
      @Path('requestId') String requestId);

  @DELETE('${Repo.unfollow}/{userId}')
  Future<UnfollowResponse> unfollow(
      @Header('Authorization') String token, @Path('userId') String userId);

  @GET(Repo.getFollowers)
  Future<GetFollowsResponse> getFollowers(
      @Header('Authorization') String token, @Query('page') int page);

  @GET(Repo.getFollowing)
  Future<GetFollowsResponse> getFollowing(
      @Header('Authorization') String token, @Query('page') int page);

  @GET(Repo.getFollowRequestsReceived)
  Future<GetFollowRequestsResponse> getFollowRequestsReceived(
      @Header('Authorization') String token, @Query('page') int page);

  @GET(Repo.getFollowRequestsSent)
  Future<GetFollowRequestsResponse> getFollowRequestsSent(
      @Header('Authorization') String token, @Query('page') int page);
}

@JsonSerializable()
class RejectFollowResponse {
  @JsonKey(name: 'message')
  String? message;

  RejectFollowResponse({this.message});

  factory RejectFollowResponse.fromJson(Map<String, dynamic> json) =>
      _$RejectFollowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RejectFollowResponseToJson(this);
}

@JsonSerializable()
class UnfollowResponse {
  @JsonKey(name: 'message')
  String? message;

  UnfollowResponse({this.message});

  factory UnfollowResponse.fromJson(Map<String, dynamic> json) =>
      _$UnfollowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UnfollowResponseToJson(this);
}

@JsonSerializable()
class GetFollowsResponse {
  @JsonKey(name: 'data')
  List<User>? users;

  @JsonKey(name: 'meta')
  Meta? meta;

  GetFollowsResponse({this.users, this.meta});

  factory GetFollowsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFollowsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetFollowsResponseToJson(this);
}

@JsonSerializable()
class GetFollowRequestsResponse {
  @JsonKey(name: 'data')
  List<FollowRequest>? requests;

  @JsonKey(name: 'meta')
  Meta? meta;

  GetFollowRequestsResponse({this.requests, this.meta});

  factory GetFollowRequestsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFollowRequestsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetFollowRequestsResponseToJson(this);
}
