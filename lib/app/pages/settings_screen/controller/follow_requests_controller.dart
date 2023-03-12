import 'dart:convert';
import 'dart:developer';

import 'package:atlas_mobile/app/model/follow_request.model.dart';
import 'package:atlas_mobile/app/services/follow/follow.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../utility/shared_preferences.dart';

class FollowRequestsController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  var isLoading = false.obs;
  var followRequests = <FollowRequest>[].obs;
  var hasNextPage = false.obs;
  int page = 1;

  ScrollController scrollController = ScrollController();

  goToPreviousScreen() {
    Get.back();
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  getFollowRequests() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final followService = FollowService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    followService
        .getFollowRequestsReceived('Bearer $accessToken', 1)
        .then((response) {
      hasNextPage.value = response.meta!.hasNextPage!;
      page = 1;
      if (hasNextPage.value) {
        page++;
      }

      followRequests.value = response.requests!;
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  loadMore() async {
    if (hasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final followService = FollowService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      followService
          .getFollowRequestsReceived('Bearer $accessToken', page)
          .then((response) {
        followRequests.value.addAll(response.requests!);
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

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);
  }

  acceptFollowRequest(String id) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final followService = FollowService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    followService
        .acceptFollowRequest('Bearer $accessToken', id)
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Follow request accepted');
      getFollowRequests();

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  rejectFollowRequest(String id) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final followService = FollowService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    followService
        .rejectFollowRequest('Bearer $accessToken', id)
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Follow request rejected');
      getFollowRequests();

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }
}
