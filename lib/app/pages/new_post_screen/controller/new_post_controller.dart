import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:atlas_mobile/app/utility/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/post/post.service.dart';
import '../../../utility/shared_preferences.dart';
import '../../../utility/snackbar.dart';
import '../../home_screen/views/home_screen.dart';

class NewPostController extends GetxController {
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
  var tag = 'personal';
  var visibility = 'public';

  createScrap() async {
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);
    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');
    postService
        .createPost('Bearer $accessToken', 'caption', 'location', 'private',
            'tag', 'type', File(scrap!.path))
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Scrap Created');
      Get.to(() => const HomeScreen());
    }).catchError((error) {
      log(error.toString());
    });
  }

  createScrapbook() async {
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);
    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');
    CreateScrapbookDto dto =
        CreateScrapbookDto('caption', 'location', 'private');
    postService.createScrapbook('Bearer $accessToken', dto).then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Scrap Created');
      Get.to(() => const HomeScreen());
    }).catchError((error) {
      log(error.toString());
    });
  }

  TextEditingController eventNameTextFieldController = TextEditingController();
  TextEditingController participantsTextFieldController =
      TextEditingController();
  TextEditingController descriptionTextFieldController =
      TextEditingController();
  TextEditingController captionTextFieldController = TextEditingController();
  TextEditingController peopleTextFieldController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  TextEditingController nameTextFieldController = TextEditingController();

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
}
