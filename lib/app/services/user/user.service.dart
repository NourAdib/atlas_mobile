import 'dart:io';

import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../model/meta.model.dart';

part 'user.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET(Repo.userProfile)
  Future<User> getUserProfile(@Header('Authorization') String token);

  @PATCH(Repo.notificationPreference)
  Future<User> updateNotificationPreference(
      @Header('Authorization') String token,
      @Query('preference') String preference);

  @PATCH(Repo.updatePassword)
  Future<UpdateResponse> updatePassword(@Header('Authorization') String token,
      @Body() UpdateUserPasswordRequest request);

  @PATCH(Repo.updateEmail)
  Future<UpdateResponse> updateEmail(@Header('Authorization') String token,
      @Body() UpdateUserEmailRequest request);

  @PATCH(Repo.updateDOB)
  Future<UpdateResponse> updateDOB(@Header('Authorization') String token,
      @Body() UpdateUserDOBRequest request);

  @PATCH(Repo.updateGender)
  Future<UpdateResponse> updateGender(
      @Header('Authorization') String token, @Query('gender') String gender);

  @PATCH(Repo.updateRole)
  Future<UpdateResponse> updateRole(
      @Header('Authorization') String token, @Query('role') String role);

  @PATCH(Repo.updateBio)
  Future<UpdateResponse> updateBio(@Header('Authorization') String token,
      @Body() UpdateUserBioRequest request);

  @PATCH(Repo.updateUsername)
  Future<UpdateResponse> updateUsername(@Header('Authorization') String token,
      @Query('username') String username);

  @PATCH(Repo.updateAvatar)
  @MultiPart()
  Future<UpdateResponse> updateAvatar(
    @Header('Authorization') String token,
    @Part() File avatar,
  );

  @POST(Repo.postAvatar)
  @MultiPart()
  Future<UpdateResponse> uploadAvatar(
    @Header('Authorization') String token,
    @Part() File avatar,
  );

  @DELETE(Repo.deleteAvatar)
  Future<UpdateResponse> deleteAvatar(@Header('Authorization') String token);

  @DELETE(Repo.deleteUser)
  Future<UpdateResponse> deleteUser(@Header('Authorization') String token);

  @GET(Repo.searchUser)
  Future<UserSearchResponse> searchUser(@Header('Authorization') String token,
      @Query('searchTerm') String searchTerm);

  @GET('${Repo.userById}/{userId}')
  Future<User> getPostById(
      @Header('Authorization') String token, @Path('userId') String userId);
}

@JsonSerializable()
class UpdateUserPasswordRequest {
  @JsonKey(name: 'currentPassword')
  String? currentPassword;
  @JsonKey(name: 'password')
  String? newPassword;
  @JsonKey(name: 'confirmPassword')
  String? confirmNewPassword;

  UpdateUserPasswordRequest(
      {this.currentPassword, this.newPassword, this.confirmNewPassword});

  factory UpdateUserPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserPasswordRequestToJson(this);
}

@JsonSerializable()
class UpdateResponse {
  @JsonKey(name: 'message')
  String? message;

  UpdateResponse({this.message});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateResponseToJson(this);
}

@JsonSerializable()
class UpdateUserEmailRequest {
  @JsonKey(name: 'email')
  String? email;

  UpdateUserEmailRequest({this.email});

  factory UpdateUserEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserEmailRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserEmailRequestToJson(this);
}

@JsonSerializable()
class UpdateUserDOBRequest {
  @JsonKey(name: 'dateOfBirth')
  DateTime? dateOfBirth;

  UpdateUserDOBRequest({this.dateOfBirth});

  factory UpdateUserDOBRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDOBRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserDOBRequestToJson(this);
}

@JsonSerializable()
class UserSearchResponse {
  @JsonKey(name: 'data')
  List<User>? users;

  @JsonKey(name: 'meta')
  Meta? meta;

  UserSearchResponse({this.users, this.meta});

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserSearchResponseToJson(this);
}

@JsonSerializable()
class UpdateUserBioRequest {
  @JsonKey(name: 'bio')
  String? bio;

  UpdateUserBioRequest({this.bio});

  factory UpdateUserBioRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserBioRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserBioRequestToJson(this);
}
