import 'dart:convert';

import 'package:atlas_mobile/app/model/event_clue.model.dart';
import 'package:atlas_mobile/app/pages/home_screen/views/home_screen.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../model/event.model.dart';
import '../../../model/user.model.dart';
import '../../../services/event/event.service.dart';
import '../views/clues_list_screen.dart';

class EventDetailsController extends GetxController {
  var width = Get.width;
  var height = Get.height;
  var isLoading = false.obs;
  var isOwner = false.obs;
  var hasJoined = false.obs;
  var isFull = false.obs;

  var cluesList = <EventClue>[].obs;

  User user = User();
  Event event = Event();

  ScrollController cluesScrollController = ScrollController();

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
      setOwnership(event.creator!.id!);
      setHasJoined(event.participants!);
      setIsFull(event.participants ?? [], event.numberOfParticipants ?? 0);
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  getParsedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);
  }

  setOwnership(String id) {
    if (user.id == id) {
      isOwner.value = true;
    } else {
      isOwner.value = false;
    }
  }

  setHasJoined(List<User> participants) {
    participants.forEach((element) {
      if (element.id == user.id) {
        hasJoined.value = true;
      }
    });
  }

  setIsFull(List<User> participants, int numberOfParticipants) {
    participants.length == numberOfParticipants
        ? isFull.value = true
        : isFull.value = false;
  }

  setEvent(Event event) {
    this.event = event;
  }

  joinEvent() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    eventsService.joinEvent('Bearer $accessToken', event.id!).then((response) {
      hasJoined.value = true;
      SnackBarService.showSuccessSnackbar('Success', 'Joined event');
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  deleteEvent() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    eventsService
        .deleteEvent('Bearer $accessToken', event.id!)
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Deleted event');
      Get.to(() => const HomeScreen());
      toggleLoading();
    }).catchError((error) {
      errorHandler(error);
    });
  }

  goToGoalPage() {
    Get.defaultDialog(
      title: 'Goal Details',
      content: Text(event.goal?.text ?? ''),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF182335),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(Get.width * 0.46, Get.height * 0.07),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  goToCluesPage() {
    cluesList.assignAll(event.clues ?? []);

    Get.to(() => CluesListScreen());
  }
}
