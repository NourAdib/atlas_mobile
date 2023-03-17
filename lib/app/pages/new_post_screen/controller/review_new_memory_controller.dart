import 'dart:convert';
import 'dart:io';

import 'package:atlas_mobile/app/pages/home_screen/views/home_screen.dart';
import 'package:atlas_mobile/app/services/memories/memories.service.dart';
import 'package:atlas_mobile/app/utility/get_location.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../utility/shared_preferences.dart';

class ReviewNewMemoryController extends GetxController {
  var memory = '';
  var height = Get.height;
  var width = Get.width;
  var private = false.obs;
  var public = true.obs;
  var isLoading = false.obs;

  goToPrreviousScreen() {
    Get.back();
  }

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

  createMemory() async {
    if (locationTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Location field cannot be empty');
      return;
    }
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final memoryService = MemoriesService(dio);
    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    var location = await LocationService.getCurrentLocation();
    memoryService
        .createMemory(
            'Bearer $accessToken',
            locationTextFieldController.text,
            public.value ? 'public' : 'private',
            location?.longitude.toString() ?? '',
            location?.latitude.toString() ?? '',
            File(memory))
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Scrap Created');
      toggleLoading();
      Get.to(() => const HomeScreen());
    }).catchError((error) {
      errorHandler(error);
      toggleLoading();
    });
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

  setMemoryPath(String memoryIn) {
    memory = memoryIn;
  }
}
