import 'dart:developer';

import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../main/controller/navigation_controller.dart';
import '../../services/memories/memories.service.dart';
import '../../services/user/user.service.dart';
import '../../utility/shared_preferences.dart';

class MemoryDetailsScreenController extends GetxController {
  final navigationC = Get.find<NavigationController>();

  var isLoading = false.obs;
  var isOwner = false.obs;
  var height = Get.height;
  var width = Get.width;

  Memory memory = Memory();
  User user = User();

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  getUserProfile() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.getUserProfile('Bearer $accessToken').then((response) {
      user = response;
      setOwnership(memory.user!.id!);

      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> deleteMemory(String id) async {
    final dio = Dio(); // Provide a dio instance
    final memoriesService = MemoriesService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    memoriesService.deleteMemory('Bearer $accessToken', id).then((response) {
      SnackBarService.showSuccessSnackbar(
          "Memory deleted", "Memory deleted successfully");
      navigationC.onItemTap(2);
    }).catchError((error) {
      log(error.toString());
      SnackBarService.showErrorSnackbar(
          "Memory not deleted", "Something went wrong. Please try again later");
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  setMemory(Memory memory) {
    this.memory = memory;
  }

  setOwnership(String id) {
    if (user.id == id) {
      isOwner.value = true;
    } else {
      isOwner.value = false;
    }
  }
}
