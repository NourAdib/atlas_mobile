import 'dart:developer';

import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/widgets/post_details/post_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ProfileScreenController extends GetxController {
  double width = Get.width;
  double height = Get.height;
  var isLoading = false.obs;
  User user = User();
  ScrollController postsScrollController = ScrollController();
  ScrollController scrapbookScrollController = ScrollController();
  var postsList = [].obs;
  var scrapbooksList = [].obs;
  var isDisplayingPosts = false.obs;
  var isDisplayingMemories = false.obs;
  var isDisplayingScrapbooks = false.obs;
  var isDisplayingEvents = false.obs;
  var postHasNextPage = false.obs;
  var scrapbookHasNextPage = false.obs;

  int postPage = 1;
  int scrapbookPage = 1;

  @override
  void onInit() {
    super.onInit();
    postsScrollController.addListener(_postsScrollListener);
    scrapbookScrollController.addListener(_scrapbookScrollListener);
  }

  @override
  void dispose() {
    postsScrollController.removeListener(_postsScrollListener);
    postsScrollController.dispose();
    scrapbookScrollController.removeListener(_scrapbookScrollListener);
    scrapbookScrollController.dispose();
    super.dispose();
  }

  void _postsScrollListener() {
    if (postsScrollController.positions.last.pixels ==
        postsScrollController.positions.last.maxScrollExtent) {
      log('reached end of posts list');
      getMorePosts();
    }
  }

  void _scrapbookScrollListener() {
    if (scrapbookScrollController.positions.last.pixels ==
        scrapbookScrollController.positions.last.maxScrollExtent) {
      getMoreScrapbooks();
    }
  }

  loadData() {
    getUserProfile();
    displayUserPosts();
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

    postService.getUserPosts('Bearer $accessToken', postPage).then((response) {
      postsList.assignAll(response.posts!);
      postHasNextPage.value = response.meta!.hasNextPage!;
      if (postHasNextPage.value) {
        postPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  displayUserPosts() {
    if (isDisplayingPosts.value == false) {
      isDisplayingEvents.value = false;
      isDisplayingMemories.value = false;
      isDisplayingPosts.value = true;
      isDisplayingScrapbooks.value = false;
      if (postPage == 1) {
        getUserPosts();
      }
    }
  }

  displayUserMemories() {
    if (isDisplayingMemories.value == false) {
      isDisplayingEvents.value = false;
      isDisplayingMemories.value = true;
      isDisplayingPosts.value = false;
      isDisplayingScrapbooks.value = false;
      getUserMemories();
    }
  }

  displayUserScrapbooks() {
    if (isDisplayingScrapbooks.value == false) {
      isDisplayingEvents.value = false;
      isDisplayingMemories.value = false;
      isDisplayingPosts.value = false;
      isDisplayingScrapbooks.value = true;
      if (scrapbookPage == 1) {
        getUserScrapbooks();
      }
    }
  }

  displayUserEvents() {
    if (isDisplayingEvents.value == false) {
      isDisplayingEvents.value = true;
      isDisplayingMemories.value = false;
      isDisplayingPosts.value = false;
      isDisplayingScrapbooks.value = false;
      getUserEvents();
    }
  }

  getUserMemories() {
    log('getUserMemories');
  }

  getUserScrapbooks() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService
        .getUserScrapbooks('Bearer $accessToken', scrapbookPage)
        .then((response) {
      scrapbooksList.assignAll(response.scrapbooks!);
      scrapbookHasNextPage.value = response.meta!.hasNextPage!;
      if (scrapbookHasNextPage.value) {
        scrapbookPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getUserEvents() {
    log('getUserEvents');
  }

  getMorePosts() async {
    if (postHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final postService = PostService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      postService
          .getUserPosts('Bearer $accessToken', postPage)
          .then((response) {
        postsList.value.addAll(response.posts!);
        postHasNextPage.value = response.meta!.hasNextPage!;
        if (postHasNextPage.value) {
          postPage++;
        }
        toggleLoading();
      }).catchError((error) {
        log(error.toString());
      });
    }
  }

  getMoreScrapbooks() async {
    if (scrapbookHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final postService = PostService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      postService
          .getUserScrapbooks('Bearer $accessToken', scrapbookPage)
          .then((response) {
        scrapbooksList.value.addAll(response.scrapbooks!);
        scrapbookHasNextPage.value = response.meta!.hasNextPage!;
        if (scrapbookHasNextPage.value) {
          scrapbookPage++;
        }
        toggleLoading();
      }).catchError((error) {
        log(error.toString());
      });
    }
  }

  getCurrentPost(String postId) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    return postService
        .getPostById('Bearer $accessToken', postId)
        .then((response) {
      toggleLoading();
      return response;
    }).catchError((error) {
      log(error.toString());
    });
  }

  openPostDetails(String postId) async {
    Post detailedPost = await getCurrentPost(postId);
    Get.to(() =>
        PostDetailsScreen(post: detailedPost, height: height, width: width));
  }
}
