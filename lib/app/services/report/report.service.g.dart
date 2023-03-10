// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportPostDto _$ReportPostDtoFromJson(Map<String, dynamic> json) =>
    ReportPostDto(
      postId: json['id'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$ReportPostDtoToJson(ReportPostDto instance) =>
    <String, dynamic>{
      'id': instance.postId,
      'reason': instance.reason,
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
    baseUrl ??= 'http://192.168.1.175:3000';
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
