import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'meta.model.g.dart';

@JsonSerializable()
class Meta {
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'take')
  int? take;
  @JsonKey(name: 'itemCount')
  int? itemCount;
  @JsonKey(name: 'pageCount')
  int? pageCount;
  @JsonKey(name: 'hasPreviousPage')
  bool? hasPreviousPage;
  @JsonKey(name: 'hasNextPage')
  bool? hasNextPage;

  Meta(
      {this.page,
      this.take,
      this.itemCount,
      this.pageCount,
      this.hasPreviousPage,
      this.hasNextPage});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
