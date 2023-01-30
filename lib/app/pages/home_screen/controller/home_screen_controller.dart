import 'dart:developer';
import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/services/feed/feed.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HomeScreenController extends GetxController {
  var selectedIndex = 0.obs;
  double width = Get.width;
  double height = Get.height;
  ScrollController scrollController = ScrollController();

  var feedPosts = [].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    getFeed();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  onItemTap(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        log('Maps Screen');
        Get.toNamed('/maps');
        break;
      case 1:
        log('Search Screen');
        break;
      case 2:
        log('Home Screen');
        break;
      case 3:
        log('New Post Screen');
        break;
      case 4:
        log('Profile Screen');
        break;
      default:
        log('Home Screen');
    }
  }

  getFeed() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final feedService = FeedService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    feedService.getFeed('Bearer $accessToken').then((response) {
      feedPosts.value = response.posts!;
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      log('End of the list');
    }
  }
}
