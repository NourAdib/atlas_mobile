import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'subscription.service.g.dart';

@RestApi(baseUrl: Repo.url)
abstract class SubscriptionService {
  factory SubscriptionService(Dio dio, {String baseUrl}) = _SubscriptionService;

  @POST(Repo.subscribe)
  Future<SubscriptionResponse> subscribe(@Header('Authorization') String token);

  @POST(Repo.unsubscribe)
  Future<UnsubscribeResponse> unsubscribe(
      @Header('Authorization') String token);
}

@JsonSerializable()
class SubscriptionResponse {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'url')
  String? url;

  SubscriptionResponse({this.message, this.url});

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionResponseToJson(this);
}

@JsonSerializable()
class UnsubscribeResponse {
  @JsonKey(name: 'message')
  String? message;

  UnsubscribeResponse({this.message});

  factory UnsubscribeResponse.fromJson(Map<String, dynamic> json) =>
      _$UnsubscribeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UnsubscribeResponseToJson(this);
}
