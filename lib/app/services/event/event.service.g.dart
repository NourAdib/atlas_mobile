// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProximityEventsRequest _$ProximityEventsRequestFromJson(
        Map<String, dynamic> json) =>
    ProximityEventsRequest()
      ..latitude = json['latitude'] as String?
      ..longitude = json['longitude'] as String?;

Map<String, dynamic> _$ProximityEventsRequestToJson(
        ProximityEventsRequest instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,

EventsResponse _$EventsResponseFromJson(Map<String, dynamic> json) =>
    EventsResponse(
      events: (json['data'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventsResponseToJson(EventsResponse instance) =>
    <String, dynamic>{
      'data': instance.events,
      'meta': instance.meta,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'message': instance.message,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _EventsService implements EventsService {
  _EventsService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://10.6.130.39:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Event>> getProximityEvents(
    token,
    request,
  Future<EventsResponse> getUserEvents(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EventsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/user-events',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Event> getEventById(
    token,
    id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Event>>(Options(
      method: 'POST',
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Event>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/proximity-events',
              '/event/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Event.fromJson(i as Map<String, dynamic>))
        .toList();
    final value = Event.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> deleteEvent(
  Future<EventsResponse> getJoinedEvents(
    token,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EventsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/joined-events',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Event> joinEvent(
    token,
    id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/event/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
  }

  @override
  Future<void> joinEvent(
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Event>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/join-event/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Event.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> deleteEvent(
    token,
    id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/event/join-event/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Response.fromJson(_result.data!);
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
