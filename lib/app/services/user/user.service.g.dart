// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPasswordRequest _$UpdateUserPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserPasswordRequest(
      currentPassword: json['currentPassword'] as String?,
      newPassword: json['password'] as String?,
      confirmNewPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$UpdateUserPasswordRequestToJson(
        UpdateUserPasswordRequest instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'password': instance.newPassword,
      'confirmPassword': instance.confirmNewPassword,
    };

UpdateUserPasswordResponse _$UpdateUserPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserPasswordResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateUserPasswordResponseToJson(
        UpdateUserPasswordResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

UpdateUserEmailRequest _$UpdateUserEmailRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserEmailRequest(
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UpdateUserEmailRequestToJson(
        UpdateUserEmailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

UpdateUserEmailResponse _$UpdateUserEmailResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserEmailResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateUserEmailResponseToJson(
        UpdateUserEmailResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

UpdateUserDOBRequest _$UpdateUserDOBRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserDOBRequest(
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
    );

Map<String, dynamic> _$UpdateUserDOBRequestToJson(
        UpdateUserDOBRequest instance) =>
    <String, dynamic>{
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
    };

UpdateUserDOBResponse _$UpdateUserDOBResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserDOBResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateUserDOBResponseToJson(
        UpdateUserDOBResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

UpdateUserGenderResponse _$UpdateUserGenderResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserGenderResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateUserGenderResponseToJson(
        UpdateUserGenderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

UpdateUserRoleResponse _$UpdateUserRoleResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserRoleResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateUserRoleResponseToJson(
        UpdateUserRoleResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

DeleteUserResponse _$DeleteUserResponseFromJson(Map<String, dynamic> json) =>
    DeleteUserResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeleteUserResponseToJson(DeleteUserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

UserSearchResponse _$UserSearchResponseFromJson(Map<String, dynamic> json) =>
    UserSearchResponse(
      users: (json['data'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSearchResponseToJson(UserSearchResponse instance) =>
    <String, dynamic>{
      'data': instance.users,
      'meta': instance.meta,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _UserService implements UserService {
  _UserService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://192.168.1.175:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<User> getUserProfile(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/profile',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<User> updateNotificationPreference(
    token,
    preference,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'preference': preference};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/notification-preferences',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateUserPasswordResponse> updatePassword(
    token,
    request,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateUserPasswordResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/password',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateUserPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateUserEmailResponse> updateEmail(
    token,
    request,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateUserEmailResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/email',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateUserEmailResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateUserDOBResponse> updateDOB(
    token,
    request,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateUserDOBResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/dateOfBirth',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateUserDOBResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateUserGenderResponse> updateGender(
    token,
    gender,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'gender': gender};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateUserGenderResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/gender',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateUserGenderResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateUserRoleResponse> updateRole(
    token,
    role,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'role': role};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateUserRoleResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/role',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateUserRoleResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteUserResponse> deleteUser(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DeleteUserResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/delete',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteUserResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserSearchResponse> searchUser(
    token,
    searchTerm,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'searchTerm': searchTerm};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserSearchResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserSearchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<User> getPostById(
    token,
    userId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/profile/${userId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
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
