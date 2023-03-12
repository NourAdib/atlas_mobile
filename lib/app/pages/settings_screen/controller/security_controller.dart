import 'dart:convert';
import 'dart:developer';

import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../utility/shared_preferences.dart';

class SecurityController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  var isLoading = false.obs;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  goToPreviousScreen() {
    Get.back();
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  changePassword() async {
    if (currentPasswordController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Current Password is required');
      return;
    }
    if (newPasswordController.text.isEmpty) {
      SnackBarService.showErrorSnackbar('Error', 'New Password is required');
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Confirm Password is required');
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      SnackBarService.showErrorSnackbar('Error', 'Passwords do not match');
      return;
    }

    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    UpdateUserPasswordRequest request = UpdateUserPasswordRequest(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
      confirmNewPassword: confirmPasswordController.text,
    );
    userService.updatePassword('Bearer $accessToken', request).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Password changed');

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);
  }
}
