import 'dart:io';

import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'notification.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class NotificationService {
  factory NotificationService(Dio dio, {String baseUrl}) = _NotificationService;

  @POST('${Repo.notificationRegistrationPath}/{fcmToken}')
  Future<NotificationResponse> signupToNotifications(
      @Header('Authorization') String token, @Path('fcmToken') String fcmToken);
}

@JsonSerializable()
class NotificationResponse {
  @JsonKey(name: 'message')
  String? message;

  NotificationResponse({this.message});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
