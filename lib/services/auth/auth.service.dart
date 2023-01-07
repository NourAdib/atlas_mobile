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

  /*  @POST("/auth/register")
  Future<RegisterResponse> register(@Body() RegisterRequest request); */
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
