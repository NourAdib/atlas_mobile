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
  var hasNextPage = false.obs;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    getFeed(1);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
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

  getFeed(int pageToLoad) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final feedService = FeedService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    feedService.getFeed('Bearer $accessToken', pageToLoad).then((response) {
      feedPosts.value = response.posts!;
      hasNextPage.value = response.meta!.hasNextPage!;
      if (hasNextPage.value) {
        page++;
      }

      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void _scrollListener() {
    if (scrollController.positions.last.pixels ==
        scrollController.positions.last.maxScrollExtent) {
      getMorePosts();
    }
  }

  reloadFeed() async {
    page = 1;
    await getFeed(1);
  }

  getMorePosts() async {
    if (hasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final feedService = FeedService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      feedService.getFeed('Bearer $accessToken', page).then((response) {
        feedPosts.value.addAll(response.posts!);
        hasNextPage.value = response.meta!.hasNextPage!;
        if (hasNextPage.value) {
          page++;
        }
        toggleLoading();
      }).catchError((error) {
        log(error.toString());
      });
    }
  }
}
