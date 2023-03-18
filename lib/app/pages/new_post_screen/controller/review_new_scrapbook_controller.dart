import 'dart:convert';
import 'dart:developer';

import 'package:atlas_mobile/app/pages/home_screen/views/home_screen.dart';
import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../../main/controller/navigation_controller.dart';

class ReviewNewScrapbookController extends GetxController {
  final navigationC = Get.find<NavigationController>();

  var height = Get.height;
  var width = Get.width;
  var private = false.obs;
  var public = true.obs;
  var isLoading = false.obs;

  goToPrreviousScreen() {
    Get.back();
  }

  TextEditingController captionTextFieldController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  choosePrivate() {
    if (private.value == false) {
      private.value = true;
      public.value = false;
    }
  }

  choosePublic() {
    if (public.value == false) {
      public.value = true;
      private.value = false;
    }
  }

  createScrapbook() async {
    if (captionTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Caption field cannot be empty');
      return;
    }
    if (locationTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Location field cannot be empty');
      return;
    }
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);
    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');
    CreateScrapbookDto dto = CreateScrapbookDto(captionTextFieldController.text,
        locationTextFieldController.text, private.value ? 'private' : 'public');
    postService.createScrapbook('Bearer $accessToken', dto).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Scrap Created');
      navigationC.onItemTap(2);
    }).catchError((error) {
      errorHandler(error);
    });
    toggleLoading();
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);
  }
}
