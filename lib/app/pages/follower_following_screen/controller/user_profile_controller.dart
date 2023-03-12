import 'dart:convert';
import 'dart:developer';

import 'package:atlas_mobile/app/model/enums/reportReasons.enum.dart';
import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/block/block.service.dart';
import 'package:atlas_mobile/app/services/follow/follow.service.dart';
import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/services/report/report.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:atlas_mobile/app/widgets/post_details/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class UserProfileScreenController extends GetxController {
  User visitedUser;

  UserProfileScreenController({required this.visitedUser});

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
  var followRequestHasNextPage = false.obs;
  var isFollowing = false.obs;
  var sentFollowRequest = false.obs;
  var followRequestStatus = ''.obs;
  var isBlocked = false.obs;

  int postPage = 1;
  int followRequestPage = 1;
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
    getUserProfileById();

    if (isFollowing.value) {
      displayUserPosts();
    }

    if (!isFollowing.value) {
      setSendFollowRequest();
    }
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

  getUserProfileById() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService
        .getPostById('Bearer $accessToken', visitedUser.id ?? '')
        .then((response) {
      visitedUser = response;
      response.followers?.forEach((element) {
        if (user.id == element.followedBy?.id) {
          isFollowing.value = true;
          displayUserPosts();
        }
      });

      response.blockedBy?.forEach((element) {
        if (user.id == element.blockingUser?.id) {
          isBlocked.value = true;
        }
      });
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

    postService
        .getFollowingsPosts(
            'Bearer $accessToken', visitedUser.id ?? '', postPage)
        .then((response) {
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
      if (postPage == 1 && isFollowing.value) {
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
      if (isFollowing.value) {
        getUserMemories();
      }
    }
  }

  displayUserScrapbooks() {
    if (isDisplayingScrapbooks.value == false) {
      isDisplayingEvents.value = false;
      isDisplayingMemories.value = false;
      isDisplayingPosts.value = false;
      isDisplayingScrapbooks.value = true;
      if (scrapbookPage == 1 && isFollowing.value) {
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
      if (isFollowing.value) {
        getUserEvents();
      }
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
        .getFollowingsScrapbooks(
            'Bearer $accessToken', visitedUser.id ?? '', scrapbookPage)
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
          .getFollowingsPosts(
              'Bearer $accessToken', visitedUser.id ?? '', postPage)
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
          .getFollowingsScrapbooks(
              'Bearer $accessToken', visitedUser.id ?? '', scrapbookPage)
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

  followUser() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final followService = FollowService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    followService
        .requestFollow('Bearer $accessToken', visitedUser.id ?? '')
        .then((response) {
      sentFollowRequest.value = true;
      followRequestStatus.value = response.status ?? '';
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
      toggleLoading();
    });
  }

  setSendFollowRequest() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final followService = FollowService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    followService
        .getFollowRequestsSent('Bearer $accessToken', followRequestPage)
        .then((response) {
      response.requests?.forEach((element) {
        if (element.requestedUser?.id == visitedUser.id) {
          sentFollowRequest.value = true;
          followRequestStatus.value = element.status ?? '';
        }
      });

      followRequestHasNextPage.value = response.meta!.hasNextPage!;
      if (followRequestHasNextPage.value) {
        followRequestPage++;
        setSendFollowRequest();
      }

      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  moreUserOptionsTap() {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isFollowing.value
              ? ListTile(
                  leading: const Icon(
                    Icons.remove_circle_outline,
                    size: 30,
                  ),
                  title: const Text('Unfollow'),
                  onTap: () async {
                    Get.back();
                    unFollowUser();
                  },
                )
              : const SizedBox(),
          isBlocked.value
              ? ListTile(
                  leading: const Icon(
                    Icons.block_outlined,
                    size: 30,
                  ),
                  title: const Text('Unblock'),
                  onTap: () async {
                    Get.back();
                    unblockUser();
                  },
                )
              : ListTile(
                  leading: const Icon(
                    Icons.block_outlined,
                    size: 30,
                  ),
                  title: const Text('Block'),
                  onTap: () async {
                    Get.back();
                    blockUser();
                  },
                ),
          ListTile(
            leading: const Icon(
              Icons.report_outlined,
              size: 30,
            ),
            title: const Text('Report'),
            onTap: () async {
              Get.back();
              reportUser();
            },
          )
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

  unFollowUser() async {
    final dio = Dio(); // Provide a dio instance
    final userService = FollowService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService
        .unfollow('Bearer $accessToken', visitedUser.id ?? '')
        .then((response) {
      isFollowing.value = false;
      sentFollowRequest.value = false;
      followRequestStatus.value = '';

      SnackBarService.showSuccessSnackbar(
          'Success', 'You have unfollowed ${visitedUser.username}');
    }).catchError((error) {
      log(error.toString());
    });
  }

  reportUser() {
    String reportReason = '';
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('It\'s Spam'),
            onTap: () async {
              reportReason = ReportReason.spam.toString();
              sendReport(reportReason);
            },
          ),
          ListTile(
            title: const Text('It\'s Inappropriate'),
            onTap: () async {
              reportReason = ReportReason.inappropriate.toString();
              sendReport(reportReason);
            },
          ),
          ListTile(
            title: const Text('It\'s Bullying or Harassment'),
            onTap: () async {
              reportReason = 'bullying or harrassement';
              sendReport(reportReason);
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

  sendReport(String reportReason) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final reportService = ReportService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    ReportDto reportUserDto = ReportDto();
    reportUserDto.id = visitedUser.id;
    reportUserDto.reason = reportReason.split('.').last;

    reportService
        .reportUser('Bearer $accessToken', reportUserDto)
        .then((response) {
      showSuccessPopup();
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  showSuccessPopup() {
    Get.toNamed('/home');
    SnackBarService.showSuccessSnackbar(
        'Success', 'User Reported Successfully');
  }

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);
  }

  blockUser() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final blockService = BlockService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    blockService
        .blockUser('Bearer $accessToken', visitedUser.id ?? '')
        .then((response) {
      Get.toNamed('/home');
      SnackBarService.showSuccessSnackbar(
          'Success', 'User Blocked Successfully');
      isBlocked.value = true;
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  unblockUser() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final blockService = BlockService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    blockService
        .unblockUser('Bearer $accessToken', visitedUser.id ?? '')
        .then((response) {
      Get.toNamed('/home');
      SnackBarService.showSuccessSnackbar(
          'Success', 'User unblocked Successfully');
      isBlocked.value = false;
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  setVisitedUser(User user) {
    visitedUser = user;
  }
}
