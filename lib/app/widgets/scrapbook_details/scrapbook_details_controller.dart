import 'dart:developer';

import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/scrapbook.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/widgets/post_details/post_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'posts_selection.dart';

class ScrapbookDetailsScreenController extends GetxController {
  var isLoading = false.obs;
  var isOwner = false.obs;
  var height = Get.height;
  var width = Get.width;
  var postsList = <Post>[].obs;
  var userPostsList = <Post>[].obs;
  var scrapbooksList = <Scrapbook>[].obs;
  var postHasNextPage = false.obs;
  var scrapbookHasNextPage = false.obs;

  int postPage = 1;
  int scrapbookPage = 1;

  var scrapbook = Scrapbook();

  ScrollController postsScrollController = ScrollController();
  ScrollController scrapbooksScrollController = ScrollController();
  ScrollController userPostsController = ScrollController();

  User user = User();

  getUserProfile() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.getUserProfile('Bearer $accessToken').then((response) {
      user = response;
      setOwnership(scrapbook.user?.id ?? '');

      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  setOwnership(String id) {
    if (user.id == id) {
      isOwner.value = true;
    } else {
      isOwner.value = false;
    }
  }

  setScrapbook(Scrapbook scrapbookIn) {
    scrapbook = scrapbookIn;
    postsList.value = scrapbook.posts ?? [];
  }

  addPostToScrapbook(Post post, String scrapbookId) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService
        .addPostToScrapbook('Bearer $accessToken', scrapbookId, post.id ?? '')
        .then((response) {
      Get.back();
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  addPostToScrapbookWithId(String postId, String scrapbookId) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService
        .addPostToScrapbook('Bearer $accessToken', scrapbookId, postId)
        .then((response) {
      Get.back();
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  onPostClick(Post post, String scrapbookId) {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_forward_outlined),
            title: const Text('Open Scrap'),
            onTap: () async {
              openPostDetails(post.id ?? '');
            },
          ),
          ListTile(
            leading: const Icon(Icons.remove_circle_outline),
            title: const Text('Remove from Scrapbook'),
            onTap: () async {
              removePostFromScrapbook(post.id ?? '', scrapbookId);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  openPostDetails(String postId) async {
    Post detailedPost = await getCurrentPost(postId);
    Get.to(() =>
        PostDetailsScreen(post: detailedPost, height: height, width: width));
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

  removePostFromScrapbook(String postId, String scrapbookId) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService
        .removePostFromScrapbook('Bearer $accessToken', scrapbookId, postId)
        .then((response) {
      toggleLoading();
      Get.back();
      Get.back();
    }).catchError((error) {
      log(error.toString());
    });
  }

  addPost() {
    Get.to(
      () => PostsSelectionScreen(
        scrapbook: scrapbook,
      ),
    );
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
        userPostsList.value.addAll(response.posts!);
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

  getUserPosts() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postPage = 1;

    postService.getUserPosts('Bearer $accessToken', postPage).then((response) {
      userPostsList.assignAll(response.posts!);
      postHasNextPage.value = response.meta!.hasNextPage!;
      if (postHasNextPage.value) {
        postPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getUserScrapbooks() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    scrapbookPage = 1;

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

  getScrapbookThumbnail(List<Post> posts) {
    if (posts.isNotEmpty) {
      for (var post in posts) {
        if (post.imageUrl?.isNotEmpty ?? false) {
          return post.imageUrl ?? '';
        }
      }
    } else {
      return '';
    }
  }
}
