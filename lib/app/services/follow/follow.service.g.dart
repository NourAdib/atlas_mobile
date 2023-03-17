// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectFollowResponse _$RejectFollowResponseFromJson(
        Map<String, dynamic> json) =>
    RejectFollowResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$RejectFollowResponseToJson(
        RejectFollowResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

UnfollowResponse _$UnfollowResponseFromJson(Map<String, dynamic> json) =>
    UnfollowResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UnfollowResponseToJson(UnfollowResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

GetFollowsResponse _$GetFollowsResponseFromJson(Map<String, dynamic> json) =>
    GetFollowsResponse(
      users: (json['data'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetFollowsResponseToJson(GetFollowsResponse instance) =>
    <String, dynamic>{
      'data': instance.users,
      'meta': instance.meta,
    };

GetFollowRequestsResponse _$GetFollowRequestsResponseFromJson(
        Map<String, dynamic> json) =>
    GetFollowRequestsResponse(
      requests: (json['data'] as List<dynamic>?)
          ?.map((e) => FollowRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetFollowRequestsResponseToJson(
        GetFollowRequestsResponse instance) =>
    <String, dynamic>{
      'data': instance.requests,
      'meta': instance.meta,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _FollowService implements FollowService {
  _FollowService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://10.6.141.64:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<FollowRequest> requestFollow(
    token,
    userId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowRequest>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/request-follow/${userId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowRequest.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Follow> acceptFollowRequest(
    token,
    requestId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Follow>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/accept-follow/${requestId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Follow.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RejectFollowResponse> rejectFollowRequest(
    token,
    requestId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RejectFollowResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/reject-follow/${requestId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RejectFollowResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnfollowResponse> unfollow(
    token,
    userId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UnfollowResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/unfollow/${userId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UnfollowResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetFollowsResponse> getFollowers(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GetFollowsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/followers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFollowsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetFollowsResponse> getFollowing(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GetFollowsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/following',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFollowsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetFollowRequestsResponse> getFollowRequestsReceived(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetFollowRequestsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/follow-requests-received',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFollowRequestsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetFollowRequestsResponse> getFollowRequestsSent(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetFollowRequestsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/follow/follow-requests-sent',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFollowRequestsResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
