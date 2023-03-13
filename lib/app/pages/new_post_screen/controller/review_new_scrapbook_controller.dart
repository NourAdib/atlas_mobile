import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReviewNewScrapbookController extends GetxController {
  var height = Get.height;
  var width = Get.width;
  var private = false.obs;
  var public = true.obs;

  goToPrreviousScreen() {
    Get.back();
  }

  TextEditingController peopleTextFieldController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
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
