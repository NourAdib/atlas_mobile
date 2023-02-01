import 'dart:developer';

import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ProfileScreenController extends GetxController {
  double width = Get.width;
  double height = Get.height;
  var isLoading = false.obs;
  User user = User();
  var postsList = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  loadData() {
    getUserProfile();
    getUserPosts();
  }

  getUserProfile() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.getUserProfile('Bearer $accessToken').then((response) {
      user = response;
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getUserPosts() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService.getUserPosts('Bearer $accessToken').then((response) {
      postsList.assignAll(response.posts!);
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}
