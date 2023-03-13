// import 'dart:io';

// import 'package:atlas_mobile/app/services/repo.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:retrofit/http.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:dio/dio.dart';

// part 'post.service.g.dart';

// @RestApi(baseUrl: Repo.url)
// abstract class PostScrap {
//   factory PostScrap(Dio dio, {String baseUrl}) = _PostScrap;
//   @POST(Repo.newScrapPath)
//   @MultiPart()
//   Future<NewScrapResponse> postScrap(
//     @Part() String caption,
//     @Part() String people,
//     @Part() String location,
//     @Part() bool hidden,
//     @Part() File image,
//   );
// }
// @JsonSerializable()
// class NewScrapRequest{
//   @JsonKey(name: 'caption')
//   String? caption;
//   @JsonKey(name: 'people')
//   String? people;
//   @JsonKey(name: 'location')
//   String? location;
//   @JsonKey(name: 'hidden')
//   bool? hidden;
//   @JsonKey(name: 'image')
//   String? image;
// }
// class NewScrapResponse {
//   String? caption;
//   String? people;
//   String? location;
//   bool? hidden;
//   String? image;
// }
// NewScrapResponse({this.caption, 
// this.people, 
// this.location, 
// this.hidden, 
// this.image});
// factory NewScrapResponse.fromJson(Map<String, dynamic> json) =>
//       _$NewScrapResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$NewScrapResponseToJson(this);
// }