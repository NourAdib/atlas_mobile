import 'dart:developer';

import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/services/subscription/subscription.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  SubscriptionResponse subscriptionResponse = SubscriptionResponse();
  var currentPlan = ''.obs;

  var isLoading = false.obs;
  var isPremium = false.obs;
  User user = User();

  getUserProfile() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.getUserProfile('Bearer $accessToken').then((response) {
      user = response;
      currentPlan.value = user.subscriptionPlan.toString().split('.').last;
      setIsPremium();
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  subscribe() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final subscriptionService = SubscriptionService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    subscriptionService.subscribe('Bearer $accessToken').then((response) {
      subscriptionResponse = response;
      getUserProfile();
      launchURL(subscriptionResponse.url!);
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });

    SnackBarService.showSuccessSnackbar('Success', 'You have subscribed');
  }

  unsubscribe() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final subscriptionService = SubscriptionService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    subscriptionService.unsubscribe('Bearer $accessToken').then((response) {
      setIsPremium();
      getUserProfile();
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });

    SnackBarService.showSuccessSnackbar('Success', 'You have unsubscribed');
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  launchURL(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }

  setIsPremium() {
    currentPlan.value == 'Premium'
        ? isPremium.value = true
        : isPremium.value = false;
  }
}
