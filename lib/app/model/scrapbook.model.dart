import 'dart:io';

import 'package:atlas_mobile/app/model/enums/visibility.enum.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'post.model.dart';
import 'user.model.dart';

part 'scrapbook.model.g.dart';

@JsonSerializable()
class Scrapbook {
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'caption')
  String? caption;
  String? type;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'visibility')
  Visibility? visibility;
  @JsonKey(name: 'user')
  User? user;
  @JsonKey(name: 'posts')
  List<Post>? posts;

  Scrapbook({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.caption,
    this.type,
    this.location,
    this.visibility,
    this.user,
    this.posts,
  });

  factory Scrapbook.fromJson(Map<String, dynamic> json) =>
      _$ScrapbookFromJson(json);
  Map<String, dynamic> toJson() => _$ScrapbookToJson(this);
}
