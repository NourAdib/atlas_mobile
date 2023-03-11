import 'dart:developer';

import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:atlas_mobile/app/services/memories/memories.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class MemoryScreenController extends GetxController {
  var isLoading = false.obs;
  var memory = Memory().obs;

  @override
  void onInit() {
    super.onInit();
    getMemory(Get.arguments as String);
  }

  Future<void> getMemory(String id) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final memoriesService = MemoriesService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    memoriesService.getMemoryById('Bearer $accessToken', id).then((response) {
      memory.value = response;
      log(memory.value.toString());
      toggleLoading();
    }).catchError((error) {
      log(error);
      toggleLoading();
    });
  }

  Future<void> deleteMemory(String id) async {
    final dio = Dio(); // Provide a dio instance
    final memoriesService = MemoriesService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    memoriesService
        .deleteMemory('Bearer $accessToken', id)
        .then((response) {})
        .catchError((error) {
      log(error);
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}
