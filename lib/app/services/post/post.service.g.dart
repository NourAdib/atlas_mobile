// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPostsResponse _$UserPostsResponseFromJson(Map<String, dynamic> json) =>
    UserPostsResponse(
      posts: (json['data'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserPostsResponseToJson(UserPostsResponse instance) =>
    <String, dynamic>{
      'data': instance.posts,
      'meta': instance.meta,
    };

UserScrapbookResponse _$UserScrapbookResponseFromJson(
        Map<String, dynamic> json) =>
    UserScrapbookResponse(
      scrapbooks: (json['data'] as List<dynamic>?)
          ?.map((e) => Scrapbook.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserScrapbookResponseToJson(
        UserScrapbookResponse instance) =>
    <String, dynamic>{
      'data': instance.scrapbooks,
      'meta': instance.meta,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PostService implements PostService {
  _PostService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://10.6.130.39:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserPostsResponse> getUserPosts(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserPostsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/post/user-posts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserPostsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserScrapbookResponse> getUserScrapbooks(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserScrapbookResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/post/scrapbook/user-scrapbooks',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserScrapbookResponse.fromJson(_result.data!);
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
