// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeals.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppealDto _$AppealDtoFromJson(Map<String, dynamic> json) => AppealDto(
      postId: json['postId'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$AppealDtoToJson(AppealDto instance) => <String, dynamic>{
      'postId': instance.postId,
      'text': instance.text,
    };

AppealsResponse _$AppealsResponseFromJson(Map<String, dynamic> json) =>
    AppealsResponse(
      appeals: (json['data'] as List<dynamic>?)
          ?.map((e) => Appeal.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppealsResponseToJson(AppealsResponse instance) =>
    <String, dynamic>{
      'data': instance.appeals,
      'meta': instance.meta,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppealsService implements AppealsService {
  _AppealsService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://atlas-backend-xtkhgxenvq-el.a.run.app:443';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Appeal> appealPost(
    token,
    appealDto,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(appealDto.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Appeal>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/appeals/appeal-post',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Appeal.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AppealsResponse> getUserAppeals(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AppealsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/appeals/user-appeals',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AppealsResponse.fromJson(_result.data!);
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
