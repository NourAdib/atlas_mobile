import 'dart:io';

import 'package:atlas_mobile/app/model/enums/visibility.enum.dart';
import 'package:atlas_mobile/app/services/repo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'comment.model.dart';
import 'like.model.dart';
import 'user.model.dart';

part 'post.model.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: 'isTakenDown')
  bool? isTakenDown;
  @JsonKey(name: 'imageUrl')
  String? imageUrl;
  @JsonKey(name: 'imageId')
  String? imageId;
  @JsonKey(name: 'likesCount')
  int? likesCount;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'caption')
  String? caption;
  @JsonKey(name: 'tag')
  String? tag;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'visibility')
  Visibility? visibility;
  @JsonKey(name: 'imageExpiryDate')
  String? imageExpiryDate;
  @JsonKey(name: 'postedBy')
  User? postedBy;
  @JsonKey(name: 'likes')
  List<Like>? likes;
  @JsonKey(name: 'comments')
  List<Comment>? comments;

  Post(
      {this.isTakenDown,
      this.imageUrl,
      this.imageId,
      this.likesCount,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.caption,
      this.tag,
      this.type,
      this.location,
      this.visibility,
      this.imageExpiryDate,
      this.postedBy,
      this.likes,
      this.comments});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
