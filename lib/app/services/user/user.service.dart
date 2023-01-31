import 'dart:io';

import 'package:atlas_mobile/app/model/post.model.dart';
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
}
