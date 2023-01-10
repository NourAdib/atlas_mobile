import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:atlas_mobile/services/repo.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(Repo.loginPath)
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST(Repo.registerPath)
  Future<RegisterResponse> registerWithoutImage(@Body() SignUpRequest request);

  @POST(Repo.registerPath)
  @MultiPart()
  Future<RegisterResponse> registerWithImage(
    @Part() String firstName,
    @Part() String lastName,
    @Part() String email,
    @Part() String username,
    @Part() String password,
    @Part() String confirmPassword,
    @Part() String phoneNumber,
    @Part() String dateOfBirth,
    @Part() String address,
    @Part() File avatar,
  );
}

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'access_token')
  String? accessToken;

  LoginResponse({this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'password')
  String? password;

  LoginRequest();
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class SignUpRequest {
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'confirmPassword')
  String? confirmPassword;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'dateOfBirth')
  String? dateOfBirth;
  @JsonKey(name: 'address')
  String? address;

  SignUpRequest();
  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePictureUrl;

  RegisterResponse(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.profilePictureUrl});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
