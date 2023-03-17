import 'dart:convert';
import 'dart:developer';

import 'package:atlas_mobile/app/model/post_report.model.dart';
import 'package:atlas_mobile/app/services/appeals/appeals.service.dart';
import 'package:atlas_mobile/app/services/report/report.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../utility/shared_preferences.dart';

class ViewPostReportsController extends GetxController {
  String postId = '';
  var width = Get.width;
  var height = Get.height;
  var isLoading = false.obs;
  var reportsList = [].obs;
  var reportsHasNextPage = false.obs;
  var reportPage = 1;

  ScrollController reportsScrollController = ScrollController();

  goToPreviousScreen() {
    Get.back();
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  setPostId(String id) {
    postId = id;
  }

  getMoreReports() async {
    if (reportsHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final reportService = ReportService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      reportService
          .getPostReports('Bearer $accessToken', postId, reportPage)
          .then((response) {
        reportsList.value.addAll(response.reports!);
        reportsHasNextPage.value = response.meta!.hasNextPage!;
        if (reportsHasNextPage.value) {
          reportPage++;
        }
        toggleLoading();
      }).catchError((error) {
        errorHandler(error);
      });
    }
  }

  getPostReports() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final reportService = ReportService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    reportPage = 1;

    reportService
        .getPostReports('Bearer $accessToken', postId, reportPage)
        .then((response) {
      reportsList.assignAll(response.reports!);
      reportsHasNextPage.value = response.meta!.hasNextPage!;
      if (reportsHasNextPage.value) {
        reportPage++;
      }
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  onReportTap() {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.file_copy_outlined),
            title: const Text('Appeal report'),
            onTap: () async {
              appealPost();
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

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);
  }

  getParsedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  appealPost() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final appealService = AppealsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    AppealDto appealDto = AppealDto(postId: postId, text: 'test');

    appealService.appealPost('Bearer $accessToken', appealDto).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Appeal sent');
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }
}
