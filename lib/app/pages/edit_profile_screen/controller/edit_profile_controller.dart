import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:atlas_mobile/app/model/enums/gender.enum.dart';
import 'package:atlas_mobile/app/model/enums/role.enum.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/pages/settings_screen/views/account_settings/account_settings.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/image_picker.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  var isLoading = false.obs;
  var noImageSelected = true.obs;
  var hasAvatar = false.obs;
  XFile? avatar;
  var imagePath = ''.obs;
  User user = User();

  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();

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
      usernameTextEditingController.text = user.username.toString();
      bioTextEditingController.text = user.bio.toString();
      if (user.profilePictureUrl!.isEmpty) {
        hasAvatar.value = false;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  updateUserProfile() async {
    if (!noImageSelected.value) {
      await uploadImage();
    }
    if (usernameTextEditingController.text != user.username) {
      await updateUsername();
    }
    if (bioTextEditingController.text != user.bio) {
      await updateUserBio();
    }
  }

  updateUsername() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService
        .updateUsername(
      'Bearer $accessToken',
      usernameTextEditingController.text,
    )
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Username updated');
      getUserProfile();

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  updateUserBio() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    UpdateUserBioRequest request = UpdateUserBioRequest(
      bio: bioTextEditingController.text,
    );

    userService.updateBio('Bearer $accessToken', request).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Bio updated');
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
              if (avatar != null) {
                noImageSelected.value = false;
                imagePath.value = avatar!.path;
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gallery'),
            onTap: () async {
              avatar = await ImagePickerService.pickImageFromGallery();
              if (avatar != null) {
                noImageSelected.value = false;
                imagePath.value = avatar!.path;
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever_outlined),
            title: const Text('Remove Image'),
            onTap: () async {
              await deleteAvatar();
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

  goToAccountSettings() {
    Get.to(() => const AccountSettings());
  }

  deleteAvatar() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.deleteAvatar('Bearer $accessToken').then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Avatar deleted');
      getUserProfile();

      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  uploadImage() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    if (hasAvatar.value) {
      userService
          .updateAvatar('Bearer $accessToken', File(avatar!.path))
          .then((response) {
        SnackBarService.showSuccessSnackbar('Success', 'Avatar updated');
        getUserProfile();

        toggleLoading();
      }).catchError((error) {
        errorHandler(error);
      });
    } else {
      userService
          .uploadAvatar('Bearer $accessToken', File(avatar!.path))
          .then((response) {
        SnackBarService.showSuccessSnackbar('Success', 'Avatar updated');
        getUserProfile();

        toggleLoading();
      }).catchError((error) {
        errorHandler(error);
      });
    }
  }
}
