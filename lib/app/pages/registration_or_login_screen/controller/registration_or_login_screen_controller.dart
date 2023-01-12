import 'package:get/get.dart';

class RegistrationOrLoginScreenController extends GetxController {
  //Get the width of the screen
  var width = Get.width;
  var height = Get.height;

  var stripeWidth = Get.width * 0.5;
  var stripeHeight = Get.width * 0.5;

  sendToRegistrationScreen() {
    Get.toNamed('/registration');
  }

  sendToLoginScreen() {
    Get.toNamed('/login');
  }
}
