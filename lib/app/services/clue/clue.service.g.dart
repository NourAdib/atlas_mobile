// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clue.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProximityCluesRequest _$ProximityCluesRequestFromJson(
        Map<String, dynamic> json) =>
    ProximityCluesRequest()
      ..latitude = json['latitude'] as String?
      ..longitude = json['longitude'] as String?;

Map<String, dynamic> _$ProximityCluesRequestToJson(
        ProximityCluesRequest instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CluesService implements CluesService {
  _CluesService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://192.168.0.198:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Clue>> getProximityClues(
    token,
    request,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Clue>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/proximity-clues',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Clue.fromJson(i as Map<String, dynamic>))
        .toList();
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
