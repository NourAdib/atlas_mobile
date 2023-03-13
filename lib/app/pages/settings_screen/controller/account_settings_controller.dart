import 'dart:convert';
import 'dart:developer';

import 'package:atlas_mobile/app/model/enums/gender.enum.dart';
import 'package:atlas_mobile/app/model/enums/role.enum.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class AccountSettingsController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  var isLoading = false.obs;
  var role = 'standard'.obs;
  var gender = 'other'.obs;
  User user = User();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();

  List<String> roleList = [];

  List<String> genderList =
      Gender.values.map((e) => e.toString().split('.').last).toList();

  goToPreviousScreen() {
    Get.back();
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  getUserProfile() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.getUserProfile('Bearer $accessToken').then((response) {
      user = response;
      role.value = user.role.toString().split('.').last;
      gender.value = user.gender.toString().split('.').last;
      emailTextEditingController.text = user.email.toString();
      dobTextEditingController.text =
          user.dateOfBirth.toString().split('T').first;
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getRolesList() {
    List<String> list = Role.values.map((e) {
      return e.toString().split('.').last;
    }).toList();

    list.remove('admin');

    return list;
  }

  updateUserProfile() async {
    if (emailTextEditingController.text != user.email) {
      await updateUserEmail();
    }
    if (dobTextEditingController.text !=
        user.dateOfBirth.toString().split('T').first) {
      await updateUserDOB();
    }
    if (gender.value != user.gender.toString().split('.').last) {
      await updateUserGender();
    }
    if (role.value != user.role.toString().split('.').last) {
      await updateUserRole();
    }
  }

  updateUserEmail() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    UpdateUserEmailRequest request = UpdateUserEmailRequest(
      email: emailTextEditingController.text,
    );

    userService
        .updateEmail(
      'Bearer $accessToken',
      request,
    )
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Email updated');
      getUserProfile();

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  updateUserDOB() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    UpdateUserDOBRequest request = UpdateUserDOBRequest(
      dateOfBirth: DateTime.parse(dobTextEditingController.text),
    );

    userService.updateDOB('Bearer $accessToken', request).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Date of birth updated');
      getUserProfile();

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  updateUserGender() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService
        .updateGender('Bearer $accessToken', gender.value)
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Gender updated');
      getUserProfile();

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  updateUserRole() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.updateRole('Bearer $accessToken', role.value).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Role updated');
      getUserProfile();

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

    isLoading.value = false;
  }

  deleteAccount() {
    Get.defaultDialog(
      title: 'Are You Sure ?',
      middleText: 'This action cannot be undone',
      confirm: SizedBox(
        width: width * 0.3,
        height: height * 0.05,
        child: ElevatedButton(
          onPressed: () {
            deleteUser();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFFF1A1A),
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
          child: const Text('Yes'),
        ),
      ),
      cancel: SizedBox(
        width: width * 0.3,
        height: height * 0.05,
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF4f5559),
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
          child: const Text('No'),
        ),
      ),
    );
  }

  deleteUser() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.deleteUser('Bearer $accessToken').then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'User deleted');
      Get.offAllNamed('/registrationOrLogin');
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }
}
