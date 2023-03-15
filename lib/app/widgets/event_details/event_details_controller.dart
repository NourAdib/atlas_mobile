import 'dart:developer';

import 'package:atlas_mobile/app/model/event.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../model/user.model.dart';
import '../../services/event/event.service.dart';
import '../../services/user/user.service.dart';
import '../../utility/shared_preferences.dart';
import '../../utility/snackbar.dart';

class EventDetailsScreenController extends GetxController {
  var isLoading = false.obs;
  var isOwner = false.obs;
  var joined = false.obs;
  var full = false.obs;
  var height = Get.height;
  var width = Get.width;

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var visibilityController = TextEditingController();

  Event event = Event();
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
      setOwnership(event.creator!.id!);
      setJoined();
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> deleteEvent(String id) async {
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    eventsService.deleteEvent('Bearer $accessToken', id).then((response) {
      SnackBarService.showSuccessSnackbar(
          "Event deleted", "Event deleted successfully");
      Get.toNamed('/home');
    }).catchError((error) {
      log(error.toString());
      SnackBarService.showErrorSnackbar(
          "Event not deleted", "Something went wrong. Please try again later");
    });
  }

  Future<void> joinEvent(String id) async {
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared("accessToken");

    eventsService.joinEvent('Bearer $accessToken', id).then((response) {
      SnackBarService.showSuccessSnackbar(
          "Event joined", "You have joined the event successfully");
      joined.value = true;
    }).catchError((error) {
      log(error.toString());
      SnackBarService.showErrorSnackbar(
          "Event not joined", "Something went wrong. Please try again later");
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  setOwnership(String id) {
    if (user.id == id) {
      isOwner.value = true;
    } else {
      isOwner.value = false;
    }
  }

  setJoined() {
    List<String> userIds = event.participants!.map((u) => u.id!).toList();

    if (userIds.contains(user.id)) {
      joined.value = true;
    } else {
      joined.value = false;
    }
  }

  setFull() {
    if (event.participants!.length == event.numberOfParticipants) {
      full.value = true;
    } else {
      full.value = false;
    }
  }

  setEvent(Event eventIn) {
    event = eventIn;
    nameController.text = event.name!;
    descriptionController.text = event.description!;
    dateController.text = event.date!.toString().substring(0, 10);
    visibilityController.text = event.visibility!.toString().substring(11);
    setFull();
  }
}
