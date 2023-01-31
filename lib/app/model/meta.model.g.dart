// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      page: json['page'] as int?,
      take: json['take'] as int?,
      itemCount: json['itemCount'] as int?,
      pageCount: json['pageCount'] as int?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'page': instance.page,
      'take': instance.take,
      'itemCount': instance.itemCount,
      'pageCount': instance.pageCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };
