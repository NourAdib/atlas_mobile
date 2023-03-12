import 'dart:developer';

import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/pages/follower_following_screen/views/user_profile_screen.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class UserSearchScreenController extends GetxController {
  var width = Get.width;
  var height = Get.height;

  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  var users = <User>[].obs;

  searchUsers() async {
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService
        .searchUser('Bearer $accessToken', searchController.text)
        .then((response) {
      users.value = response.users ?? [];
    }).catchError((error) {
      log(error.toString());
    });
  }

  navigateToUser(User user) {
    Get.to(() => UserProfileScreen(user: user));
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}
