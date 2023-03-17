import 'dart:developer';
import 'dart:io';

import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ReviewNewScrapController extends GetxController {
  ReviewNewScrapController(this.post);
  XFile? post;
  var height = Get.height;
  var width = Get.width;
  var private = false.obs;
  var public = true.obs;
  var personal = true.obs;
  var opinion = false.obs;
  var fact = false.obs;
  goToPrreviousScreen() {
    Get.back();
  }

  TextEditingController captionTextFieldController = TextEditingController();
  TextEditingController peopleTextFieldController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  var hidden = false.obs;
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

  choosePersonal() {
    if (personal.value == false) {
      personal.value = true;
      opinion.value = false;
      fact.value = false;
    }
  }

  chooseOpinion() {
    if (opinion.value == false) {
      opinion.value = true;
      personal.value = false;
      fact.value = false;
    }
  }

  chooseFact() {
    if (fact.value == false) {
      fact.value = true;
      personal.value = false;
      opinion.value = false;
    }
  }

  createScrap() async {
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService
        .createPost('Bearer $accessToken', 'caption', 'location', 'private',
            'tag', 'type', File(post!.path))
        .then((response) {
      SnackBarService.showSuccessSnackbar('Success', 'Scrap Created');
    }).catchError((error) {
      log(error.toString());
    });
  }
}
