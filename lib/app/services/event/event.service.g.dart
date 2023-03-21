// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
    };

CreateEventDto _$CreateEventDtoFromJson(Map<String, dynamic> json) =>
    CreateEventDto()
      ..latitude = json['latitude'] as String?
      ..longitude = json['longitude'] as String?
      ..name = json['name'] as String?
      ..description = json['description'] as String?
      ..numberOfParticipants = json['numberOfParticipants'] as int?
      ..visibility = json['visibility'] as String?
      ..date =
          json['date'] == null ? null : DateTime.parse(json['date'] as String)
      ..goal = json['goal'] == null
          ? null
          : GoalDto.fromJson(json['goal'] as Map<String, dynamic>)
      ..clues = (json['clues'] as List<dynamic>?)
          ?.map((e) => ClueDto.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CreateEventDtoToJson(CreateEventDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'description': instance.description,
      'numberOfParticipants': instance.numberOfParticipants,
      'visibility': instance.visibility,
      'date': instance.date?.toIso8601String(),
      'goal': instance.goal,
      'clues': instance.clues,
    };

GoalDto _$GoalDtoFromJson(Map<String, dynamic> json) => GoalDto()
  ..latitude = json['latitude'] as String?
  ..longitude = json['longitude'] as String?
  ..text = json['text'] as String?;

Map<String, dynamic> _$GoalDtoToJson(GoalDto instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'text': instance.text,
    };

ClueDto _$ClueDtoFromJson(Map<String, dynamic> json) => ClueDto()
  ..latitude = json['latitude'] as String?
  ..longitude = json['longitude'] as String?
  ..text = json['text'] as String?;

Map<String, dynamic> _$ClueDtoToJson(ClueDto instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'text': instance.text,
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
    baseUrl ??= 'https://atlas-backend-xtkhgxenvq-el.a.run.app:443';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Event> createEvent(
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
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Event>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/create-event',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Event.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Event>> getProximityEvents(
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
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Event>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/event/proximity-events',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Event.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
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
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Event>(Options(
      method: 'GET',
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
    final value = Event.fromJson(_result.data!);
    return value;
  }

  @override
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
