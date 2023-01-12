import 'dart:developer';
import 'package:atlas_mobile/app/services/auth/auth.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
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
    if (emailTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar('Error', 'Email field cannot be empty');
      return;
    }

    if (!emailTextFieldController.text.isEmail) {
      SnackBarService.showErrorSnackbar('Error', 'Invalid email');
      return;
    }

    if (passwordTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Password field cannot be empty');
      return;
    }

    final dio = Dio(); // Provide a dio instance
    final authServiceRepo = AuthService(dio);
    final LoginRequest loginRequest = LoginRequest();
    loginRequest.email = emailTextFieldController.text;
    loginRequest.password = passwordTextFieldController.text;

    authServiceRepo.login(loginRequest).then((response) {
      SharedPreferencesService.setInShared(
          'accessToken', response.accessToken.toString());
      SnackBarService.showSuccessSnackbar('Success', 'Login successful');
      Get.offNamed('/home');
      return;
    }).catchError((error) {
      switch (error.response.statusCode) {
        case 401:
          SnackBarService.showErrorSnackbar(
              'Error', 'Invalid email or password');
          break;
        case 500:
          SnackBarService.showErrorSnackbar('Error', 'Internal server error');
          break;
        case 403:
          SnackBarService.showErrorSnackbar('Error', 'Banned user');
          break;
        default:
          SnackBarService.showErrorSnackbar('Error', 'Unknown error');
          break;
      }
    });
  }
}
