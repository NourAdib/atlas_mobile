import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

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
  Future<UpdateUserPasswordResponse> updatePassword(
      @Header('Authorization') String token,
      @Body() UpdateUserPasswordRequest request);

  @PATCH(Repo.updateEmail)
  Future<UpdateUserEmailResponse> updateEmail(
      @Header('Authorization') String token,
      @Body() UpdateUserEmailRequest request);

  @PATCH(Repo.updateDOB)
  Future<UpdateUserDOBResponse> updateDOB(@Header('Authorization') String token,
      @Body() UpdateUserDOBRequest request);

  @PATCH(Repo.updateGender)
  Future<UpdateUserGenderResponse> updateGender(
      @Header('Authorization') String token, @Query('gender') String gender);

  @PATCH(Repo.updateRole)
  Future<UpdateUserRoleResponse> updateRole(
      @Header('Authorization') String token, @Query('role') String role);

  @DELETE(Repo.deleteUser)
  Future<DeleteUserResponse> deleteUser(@Header('Authorization') String token);
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
class UpdateUserPasswordResponse {
  @JsonKey(name: 'message')
  String? message;

  UpdateUserPasswordResponse({this.message});

  factory UpdateUserPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserPasswordResponseToJson(this);
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
class UpdateUserEmailResponse {
  @JsonKey(name: 'message')
  String? message;

  UpdateUserEmailResponse({this.message});

  factory UpdateUserEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserEmailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserEmailResponseToJson(this);
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
class UpdateUserDOBResponse {
  @JsonKey(name: 'message')
  String? message;

  UpdateUserDOBResponse({this.message});

  factory UpdateUserDOBResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDOBResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserDOBResponseToJson(this);
}

@JsonSerializable()
class UpdateUserGenderResponse {
  @JsonKey(name: 'message')
  String? message;

  UpdateUserGenderResponse({this.message});

  factory UpdateUserGenderResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserGenderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserGenderResponseToJson(this);
}

@JsonSerializable()
class UpdateUserRoleResponse {
  @JsonKey(name: 'message')
  String? message;

  UpdateUserRoleResponse({this.message});

  factory UpdateUserRoleResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRoleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserRoleResponseToJson(this);
}

@JsonSerializable()
class DeleteUserResponse {
  @JsonKey(name: 'message')
  String? message;

  DeleteUserResponse({this.message});

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteUserResponseToJson(this);
}
