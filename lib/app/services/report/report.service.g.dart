// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDto _$ReportDtoFromJson(Map<String, dynamic> json) => ReportDto(
      id: json['id'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$ReportDtoToJson(ReportDto instance) => <String, dynamic>{
      'id': instance.id,
      'reason': instance.reason,
    };

PostReportsResponse _$PostReportsResponseFromJson(Map<String, dynamic> json) =>
    PostReportsResponse(
      reports: (json['data'] as List<dynamic>?)
          ?.map((e) => PostReport.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostReportsResponseToJson(
        PostReportsResponse instance) =>
    <String, dynamic>{
      'data': instance.reports,
      'meta': instance.meta,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ReportService implements ReportService {
  _ReportService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://10.6.141.64:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PostReport> reportPost(
    token,
    reportPostDto,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(reportPostDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PostReport>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/report/report-post',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostReport.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostReport> reportUser(
    token,
    reportPostDto,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(reportPostDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PostReport>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/report/report-user',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostReport.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostReportsResponse> getPostReports(
    token,
    id,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostReportsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/report/post-reports/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostReportsResponse.fromJson(_result.data!);
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
