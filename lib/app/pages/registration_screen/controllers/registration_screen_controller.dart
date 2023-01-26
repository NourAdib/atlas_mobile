import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:atlas_mobile/app/services/auth/auth.service.dart';
import 'package:atlas_mobile/app/utility/image_picker.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class RegistrationScreenController extends GetxController {
  //Get the width of the screen
  var width = Get.width;
  var height = Get.height;
  var noImageSelected = true.obs;
  XFile? avatar;
  var imagePath = ''.obs;

  TextEditingController firstNameTextFieldController = TextEditingController();
  TextEditingController lastNameTextFieldController = TextEditingController();
  TextEditingController emailTextFieldController = TextEditingController();
  TextEditingController usernameTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();
  TextEditingController confirmPasswordTextFieldController =
      TextEditingController();
  TextEditingController dobTextFieldController = TextEditingController();
  TextEditingController phoneNumberTextFieldController =
      TextEditingController();
  TextEditingController addressTextFieldController = TextEditingController();

  goToPreviousScreen() {
    Get.back();
  }

  pickImage() async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              avatar = await ImagePickerService.pickImageFromCamera();
              noImageSelected.value = false;
              imagePath.value = avatar!.path;
              log(avatar!.path);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gallery'),
            onTap: () async {
              avatar = await ImagePickerService.pickImageFromGallery();
              noImageSelected.value = false;
              imagePath.value = avatar!.path;
              log(avatar!.path);
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

  register() async {
    if (firstNameTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'First Name field cannot be empty');
      return;
    }

    if (lastNameTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Last Name field cannot be empty');
      return;
    }

    if (emailTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar('Error', 'Email field cannot be empty');
      return;
    }

    if (!emailTextFieldController.text.isEmail) {
      SnackBarService.showErrorSnackbar('Error', 'Invalid email');
      return;
    }

    if (usernameTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Username field cannot be empty');
      return;
    }

    if (emailTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar('Error', 'Email field cannot be empty');
      return;
    }

    if (dobTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar('Error', 'DOB field cannot be empty');
      return;
    }

    if (phoneNumberTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Phone Number field cannot be empty');
      return;
    }

    if (passwordTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Password field cannot be empty');
      return;
    }

    if (passwordTextFieldController.text.length < 8) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Password must be at least 8 characters long');
      return;
    }

    if (confirmPasswordTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Confirm password field cannot be empty');
      return;
    }

    if (passwordTextFieldController.text !=
        confirmPasswordTextFieldController.text) {
      SnackBarService.showErrorSnackbar('Error', 'Passwords do not match');
      return;
    }

    DateTime date;
    try {
      date = DateTime.parse(dobTextFieldController.text);
      log(date.toString());
    } catch (e) {
      SnackBarService.showErrorSnackbar('Error', 'Invalid date');
      return;
    }

    DateTime currentDate = DateTime.now();
    DateTime minDate = DateTime(
      currentDate.year - 16,
      currentDate.month,
      currentDate.day,
    );

    if (date.isAfter(minDate)) {
      SnackBarService.showErrorSnackbar('Error', 'Must be 16 years or older');
      return;
    }

    sendRegistrationRequest(date);
  }

  sendRegistrationRequest(DateTime date) {
    final dio = Dio(); // Provide a dio instance
    final authServiceRepo = AuthService(dio);
    final SignUpRequest signUpRequest = SignUpRequest();
    signUpRequest.firstName = firstNameTextFieldController.text;
    signUpRequest.lastName = lastNameTextFieldController.text;
    signUpRequest.username = usernameTextFieldController.text;
    signUpRequest.email = emailTextFieldController.text;
    signUpRequest.dateOfBirth = date.toString();
    signUpRequest.phoneNumber = phoneNumberTextFieldController.text;
    signUpRequest.password = passwordTextFieldController.text;
    signUpRequest.confirmPassword = confirmPasswordTextFieldController.text;
    signUpRequest.address = addressTextFieldController.text;

    if (!((avatar?.path.toString() ?? '') == '')) {
      authServiceRepo
          .registerWithImage(
              signUpRequest.firstName!,
              signUpRequest.lastName!,
              signUpRequest.email!,
              signUpRequest.username!,
              signUpRequest.password!,
              signUpRequest.confirmPassword!,
              signUpRequest.phoneNumber!,
              signUpRequest.dateOfBirth!,
              signUpRequest.address!,
              File(avatar!.path))
          .then((value) {
        SnackBarService.showSuccessSnackbar(
            'Success', 'Registration successful');
        sendToLoginScreen();
      }).catchError((error) {
        errorHandler(error);
      });
    }

    if ((avatar?.path.toString() ?? '') == '') {
      authServiceRepo.registerWithoutImage(signUpRequest).then((value) {
        SnackBarService.showSuccessSnackbar(
            'Success', 'Registration successful');
        sendToLoginScreen();
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
  }

  sendToLoginScreen() {
    Get.offNamed('/login');
  }
}
