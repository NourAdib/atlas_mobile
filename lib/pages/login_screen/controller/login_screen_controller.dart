import 'dart:developer';
import 'package:atlas_mobile/services/auth/auth.service.dart';
import 'package:atlas_mobile/utility/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class LoginScreenController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;

  TextEditingController emailTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();

  login() {
    final dio = Dio(); // Provide a dio instance
    final authServiceRepo = AuthService(dio);
    final LoginRequest loginRequest = LoginRequest();
    loginRequest.email = emailTextFieldController.text;
    loginRequest.password = passwordTextFieldController.text;

    authServiceRepo.login(loginRequest).then((response) {
      log(response.accessToken.toString());
      Shared.setInShared('accessToken', response.accessToken.toString());
      showSuccessSnackbar('Success', 'Login successful');
    }).catchError((error) {
      switch (error.response.statusCode) {
        case 401:
          showErrorSnackbar('Error', 'Invalid email or password');
          break;
        case 500:
          showErrorSnackbar('Error', 'Internal server error');
          break;
        default:
          showErrorSnackbar('Error', 'Unknown error');
          break;
      }
    });
  }

  showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      icon: const Icon(
        Icons.cancel_outlined,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.greenAccent[400],
      colorText: Colors.white,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
