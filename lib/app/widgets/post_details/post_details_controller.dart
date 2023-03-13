import 'dart:developer';

import 'package:atlas_mobile/app/model/enums/reportReasons.enum.dart';
import 'package:atlas_mobile/app/model/enums/subscription.enum.dart';
import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/pages/view_post_reports_screen/views/view_post_reports_screen.dart';
import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/services/report/report.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:atlas_mobile/app/widgets/scrapbook_details/scrapbooks_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class PostDetailsScreenController extends GetxController {
  var isLoading = false.obs;
  var isDisplayingLikes = true.obs;
  var isDisplayingComments = false.obs;
  var isDisplayingAnalytics = false.obs;
  var isDisplayingMoreOptions = false.obs;
  var isOwner = false.obs;
  var isPremium = false.obs;
  var isLiked = false.obs;
  var height = Get.height;
  var width = Get.width;

  ScrollController likesScrollController = ScrollController();
  TextEditingController commentController = TextEditingController();

  var post = Post();

  User user = User();

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  getUserProfile() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.getUserProfile('Bearer $accessToken').then((response) {
      user = response;
      setIsLiked();
      setOwnership(post.postedBy!.id!);

      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  displayLikes() {
    if (isDisplayingLikes.value == false) {
      isDisplayingComments.value = false;
      isDisplayingAnalytics.value = false;
      isDisplayingLikes.value = true;
      isDisplayingMoreOptions.value = false;
    }
  }

  displayComments() {
    if (isDisplayingComments.value == false) {
      isDisplayingComments.value = true;
      isDisplayingAnalytics.value = false;
      isDisplayingLikes.value = false;
      isDisplayingMoreOptions.value = false;
    }
  }

  displayAnalytics() {
    if (isDisplayingLikes.value == false) {
      isDisplayingComments.value = false;
      isDisplayingAnalytics.value = true;
      isDisplayingLikes.value = false;
      isDisplayingMoreOptions.value = false;
    }
  }

  displayMoreOptions() {
    if (isDisplayingMoreOptions.value == false) {
      isDisplayingComments.value = false;
      isDisplayingAnalytics.value = false;
      isDisplayingLikes.value = false;
      isDisplayingMoreOptions.value = true;
    }
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/comment_icon.svg',
              color: const Color(0xFF9AA0A6),
            ),
            title: const Text('Add Comment'),
            onTap: () async {
              Get.back();
              openCommentModal();
            },
          ),
          isOwner.value && post.scrapbook == null
              ? ListTile(
                  leading: const Icon(
                    Icons.add_circle_outline,
                    color: Color(0xFF9AA0A6),
                  ),
                  title: const Text('Add To Scrapbook'),
                  onTap: () async {
                    addPostToScrapbook(post);
                  },
                )
              : const SizedBox(),
          isOwner.value && post.scrapbook != null
              ? ListTile(
                  leading: const Icon(
                    Icons.remove_circle_outline,
                    color: Color(0xFF9AA0A6),
                  ),
                  title: const Text('Remove from Scrapbook'),
                  onTap: () async {
                    removePostFromScrapbook(post.id ?? '', post.scrapbook!.id!);
                  },
                )
              : const SizedBox(),
          isOwner.value
              ? ListTile(
                  leading: const Icon(
                    Icons.view_list_outlined,
                    size: 30,
                  ),
                  title: const Text('View Reports'),
                  onTap: () async {
                    Get.back();
                    viewPostReports();
                  },
                )
              : const SizedBox(),
          !isOwner.value
              ? ListTile(
                  leading: const Icon(
                    Icons.report_outlined,
                    size: 30,
                  ),
                  title: const Text('Report'),
                  onTap: () async {
                    Get.back();
                    reportPost();
                  },
                )
              : const SizedBox()
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

  setOwnership(String id) {
    if (user.id == id) {
      isOwner.value = true;
    } else {
      isOwner.value = false;
    }
  }

  setIsPremium() {
    user.subscriptionPlan == SubscriptionPlan.Premium
        ? isPremium.value = true
        : isPremium.value = false;
  }

  setIsLiked() {
    for (var i = 0; i < post.likes!.length; i++) {
      if (post.likes![i].likedBy!.id == user.id) {
        isLiked.value = true;
      }
    }
  }

  likePost() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService.likePost('Bearer $accessToken', post.id!).then((response) {
      isLiked.value = true;
      post.likes!.add(response);
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
      log(error.response.toString());
    });
  }

  setPost(Post postIn) {
    post = postIn;
  }

  unlikePost() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService.unlikePost('Bearer $accessToken', post.id!).then((response) {
      isLiked.value = false;
      post.likes!.removeWhere((element) => element.likedBy!.id == user.id);
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  reportPost() {
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

  openCommentModal() {
    Get.defaultDialog(
      title: 'Add Comment',
      content: NonFilledFormField(
        screenWidth: width,
        controller: commentController,
        maxLine: 3,
        labelText: 'Comment Text',
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          Get.back();
          await addComment();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF182335),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(width * 0.46, height * 0.07),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  addComment() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    CommentDto commentDto = CommentDto();
    commentDto.text = commentController.text;

    postService
        .commentPost('Bearer $accessToken', post.id!, commentDto)
        .then((response) {
      post.comments = response.comments;
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  sendReport(String reportReason) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final reportService = ReportService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    ReportDto reportPostDto = ReportDto();
    reportPostDto.id = post.id;
    reportPostDto.reason = reportReason.split('.').last;

    reportService
        .reportPost('Bearer $accessToken', reportPostDto)
        .then((response) {
      showSuccessPopup();
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  showSuccessPopup() {
    Get.toNamed('/home');
    SnackBarService.showSuccessSnackbar(
        'Success', 'Post Reported Successfully');
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
      SnackBarService.showSuccessSnackbar(
          'Success', 'Post removed from scrapbook');
      toggleLoading();
      Get.back();
    }).catchError((error) {
      log(error.toString());
    });
  }

  addPostToScrapbook(Post post) {
    Get.to(() => ScrapbooksSelectionScreen(post: post));
  }

  viewPostReports() {
    Get.to(() => ViewPostReportsScreen(postId: post.id!));
  }
}
