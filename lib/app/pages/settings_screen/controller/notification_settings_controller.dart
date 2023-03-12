import 'dart:developer';

import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  var width = Get.width;
  var height = Get.height;

  var isMuteAllSelected = false.obs;
  var isMuteBroadcastSelected = false.obs;
  var isMuteGroupSelected = false.obs;

  var isLoading = false.obs;

  muteAll() {
    isMuteAllSelected.value = !isMuteAllSelected.value;

    if (isMuteAllSelected.value) {
      isMuteBroadcastSelected.value = true;
      isMuteGroupSelected.value = true;

      changePreference('none');
    }
  }

  muteBroadcast() {
    isMuteBroadcastSelected.value = !isMuteBroadcastSelected.value;

    if (!isMuteBroadcastSelected.value) {
      isMuteAllSelected.value = false;
    }

    if (isMuteBroadcastSelected.value && isMuteGroupSelected.value) {
      changePreference('none');
    } else if (isMuteBroadcastSelected.value) {
      changePreference('selectedGroup');
    } else if (!isMuteBroadcastSelected.value && !isMuteGroupSelected.value) {
      changePreference('all');
    }
  }

  muteSelectedGroup() {
    isMuteGroupSelected.value = !isMuteGroupSelected.value;

    if (!isMuteGroupSelected.value) {
      isMuteAllSelected.value = false;
    }

    if (isMuteBroadcastSelected.value && isMuteGroupSelected.value) {
      changePreference('none');
    } else if (isMuteGroupSelected.value) {
      changePreference('broadcast');
    } else if (!isMuteBroadcastSelected.value && !isMuteGroupSelected.value) {
      changePreference('all');
    }
  }

  changePreference(String preference) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService
        .updateNotificationPreference('Bearer $accessToken', preference)
        .then((response) {
      SnackBarService.showSuccessSnackbar(
          'Success', 'Notification preference updated');
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}
