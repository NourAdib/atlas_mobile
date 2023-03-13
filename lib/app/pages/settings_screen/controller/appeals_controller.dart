import 'dart:convert';
import 'dart:developer';

import 'package:atlas_mobile/app/model/appeal.model.dart';
import 'package:atlas_mobile/app/model/enums/gender.enum.dart';
import 'package:atlas_mobile/app/model/enums/role.enum.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/appeals/appeals.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class AppealsController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  var isLoading = false.obs;
  var appealsHasNextPage = false.obs;
  var appealPage = 1;

  var appealsList = <Appeal>[].obs;

  ScrollController appealsScrollController = ScrollController();

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  getUserAppeals() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final appealsService = AppealsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    appealPage = 1;

    appealsService
        .getUserAppeals('Bearer $accessToken', appealPage)
        .then((response) {
      appealsList.assignAll(response.appeals!);
      appealsHasNextPage.value = response.meta!.hasNextPage!;
      if (appealsHasNextPage.value) {
        appealPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getMoreAppeals() async {
    if (appealsHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final appealsService = AppealsService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      appealsService
          .getUserAppeals('Bearer $accessToken', appealPage)
          .then((response) {
        appealsList.value.addAll(response.appeals!);
        appealsHasNextPage.value = response.meta!.hasNextPage!;
        if (appealsHasNextPage.value) {
          appealPage++;
        }
        toggleLoading();
      }).catchError((error) {
        errorHandler(error);
      });
    }
  }

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);

    isLoading.value = false;
  }

  getParsedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
