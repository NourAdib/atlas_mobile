import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewNewEventController extends GetxController {
  var height = Get.height;
  var width = Get.width;
  var private = false.obs;
  var public = true.obs;

  goToPrreviousScreen() {
    Get.back();
  }

  TextEditingController eventNameTextFieldController = TextEditingController();
  TextEditingController participantsTextFieldController =
      TextEditingController();
  TextEditingController descriptionTextFieldController =
      TextEditingController();
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
}
