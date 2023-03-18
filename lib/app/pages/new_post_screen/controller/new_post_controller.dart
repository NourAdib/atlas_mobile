import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:atlas_mobile/app/services/event/event.service.dart';
import 'package:atlas_mobile/app/utility/get_location.dart';
import 'package:atlas_mobile/app/widgets/non_filled_form_field.dart';
import 'package:dio/dio.dart';
import 'package:atlas_mobile/app/utility/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../main/controller/navigation_controller.dart';
import '../../../services/post/post.service.dart';
import '../../../utility/shared_preferences.dart';
import '../../../utility/snackbar.dart';
import '../../home_screen/views/home_screen.dart';
import '../views/add_clues_screen.dart';

class NewPostController extends GetxController {
  final navigationC = Get.find<NavigationController>();

  var width = Get.width;
  var height = Get.height;
  XFile? scrap;
  XFile? memory;
  var noImageSelected = true.obs;
  var scrapPath = ''.obs;
  var memoryPath = ''.obs;
  var private = false.obs;
  var public = true.obs;
  var personal = true.obs;
  var opinion = false.obs;
  var fact = false.obs;
  var isLoading = false.obs;
  var isGoalSet = false.obs;
  var hasClues = false.obs;
  GoalDto goal = GoalDto();
  List<ClueDto> clues = <ClueDto>[];
  var tag = 'personal';
  var visibility = 'public';

  TextEditingController eventNameTextFieldController = TextEditingController();
  TextEditingController participantsTextFieldController =
      TextEditingController();
  TextEditingController descriptionTextFieldController =
      TextEditingController();
  TextEditingController captionTextFieldController = TextEditingController();
  TextEditingController peopleTextFieldController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  TextEditingController nameTextFieldController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController clueController = TextEditingController();
  TextEditingController dateTextFieldController = TextEditingController();

  createScrap() async {
    if (captionTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Caption field cannot be empty');
      return;
    }
    if (locationTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Location field cannot be empty');
      return;
    }
    toggleLoading();

    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);
    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');
    postService
        .createPost(
            'Bearer $accessToken',
            captionTextFieldController.text,
            locationTextFieldController.text,
            visibility,
            tag,
            'type',
            File(scrap!.path))
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Scrap Created');
      toggleLoading();
      navigationC.onItemTap(2);
    }).catchError((error) {
      errorHandler(error);
      toggleLoading();
    });
  }

  goToPrreviousScreen() {
    Get.back();
  }

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

  pickImageScrap() async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(color: Colors.black, Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              scrap = await ImagePickerService.pickImageFromCamera();
              if (scrap != null) {
                noImageSelected.value = false;
                scrapPath.value = scrap!.path;
                Get.toNamed('/reviewScrap');
              } else {
                goToPrreviousScreen();
              }
            },
          ),
          ListTile(
            leading: const Icon(color: Colors.black, Icons.photo),
            title: const Text('Gallery'),
            onTap: () async {
              scrap = await ImagePickerService.pickImageFromGallery();
              if (scrap != null) {
                noImageSelected.value = false;
                scrapPath.value = scrap!.path;
                Get.toNamed('/reviewScrap');
              } else {
                goToPrreviousScreen();
              }
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffEFCB68),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  pickImageMemory() async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(color: Colors.black, Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              memory = await ImagePickerService.pickImageFromCamera();
              if (memory != null) {
                noImageSelected.value = false;
                memoryPath.value = memory!.path;
                Get.toNamed('/reviewMemory');
              } else {
                goToPrreviousScreen();
              }
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffEFCB68),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }

  choosePersonal() {
    if (personal.value == false) {
      personal.value = true;
      opinion.value = false;
      fact.value = false;
      tag = 'personal';
    }
  }

  chooseOpinion() {
    if (opinion.value == false) {
      opinion.value = true;
      personal.value = false;
      fact.value = false;
      tag = 'opinion';
    }
  }

  chooseFact() {
    if (fact.value == false) {
      fact.value = true;
      personal.value = false;
      opinion.value = false;
      tag = 'fact';
    }
  }

  createEvent() async {
    Get.toNamed('/createEvent');
  }

  createScrapbookRoute() async {
    Get.toNamed('/createScrapbook');
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  createEventRequest() async {
    if (eventNameTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar('Error', 'Event name cannot be empty');
      return;
    }

    if (descriptionTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Event description cannot be empty');
      return;
    }

    if (participantsTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar(
          'Error', 'Event participants number cannot be empty');
      return;
    }

    if (dateTextFieldController.text.isEmpty) {
      SnackBarService.showErrorSnackbar('Error', 'Event date cannot be empty');
      return;
    }

    DateTime date;
    try {
      date = DateTime.parse(dateTextFieldController.text);
    } catch (e) {
      SnackBarService.showErrorSnackbar('Error', 'Invalid date');
      return;
    }

    if (!isGoalSet.value) {
      SnackBarService.showErrorSnackbar('Error', 'Event goal cannot be empty');
      return;
    }

    if (!hasClues.value) {
      SnackBarService.showErrorSnackbar('Error', 'Event clues cannot be empty');
      return;
    }

    toggleLoading();

    final dio = Dio(); // Provide a dio instance
    final eventsResponse = EventsService(dio);
    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    Position? currentPosition = await LocationService.getCurrentLocation();

    CreateEventDto dto = CreateEventDto();
    dto.name = eventNameTextFieldController.text;
    dto.description = descriptionTextFieldController.text;
    dto.visibility = visibility;
    dto.date = date;
    dto.longitude = currentPosition?.longitude.toString();
    dto.latitude = currentPosition?.latitude.toString();
    dto.numberOfParticipants = int.parse(participantsTextFieldController.text);
    dto.goal = goal;
    dto.clues = clues;

    eventsResponse.createEvent('Bearer $accessToken', dto).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Event Created');
      toggleLoading();
      navigationC.onItemTap(2);
    }).catchError((error) {
      errorHandler(error);
      toggleLoading();
    });
  }

  errorHandler(error) {
    var errorResponse = jsonDecode(error.response.toString());
    var errorMessage = errorResponse['message'] is List
        ? errorResponse['message'][0]
        : errorResponse['message'];
    SnackBarService.showErrorSnackbar('Error', errorMessage);
  }

  setGoal() {
    Get.defaultDialog(
      title: 'Set Goal',
      content: NonFilledFormField(
        screenWidth: width,
        controller: goalController,
        maxLine: 3,
        labelText: 'Goal Text',
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          Get.back();
          await addGoal();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF182335),
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
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  addGoal() async {
    toggleLoading();
    isGoalSet.value = true;
    goal.text = goalController.text;
    Position? currentPosition = await LocationService.getCurrentLocation();

    goal.longitude = currentPosition?.longitude.toString() ?? '';
    goal.latitude = currentPosition?.latitude.toString() ?? '';
    toggleLoading();
  }

  setClues() {
    Get.to(() => CluesSelectionScreen());
  }

  addClueToCluesList() {
    Get.defaultDialog(
      title: 'Set Clue',
      content: NonFilledFormField(
        screenWidth: width,
        controller: clueController,
        maxLine: 3,
        labelText: 'Clue Text',
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          Get.back();
          await addClue();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF182335),
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
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  addClue() async {
    toggleLoading();
    hasClues.value = true;
    ClueDto clue = ClueDto();
    clue.text = clueController.text;
    Position? currentPosition = await LocationService.getCurrentLocation();

    clue.longitude = currentPosition?.longitude.toString() ?? '';
    clue.latitude = currentPosition?.latitude.toString() ?? '';

    clues.add(clue);
    toggleLoading();
  }

  openCluePreviewDialog(ClueDto clue) {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Remove Clue'),
            onTap: () async {
              removeFromCluesList(clue);
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

  removeFromCluesList(ClueDto clue) {
    Get.back();

    toggleLoading();
    clues.remove(clue);
    if (clues.isEmpty) {
      hasClues.value = false;
    }
    toggleLoading();
  }
}
