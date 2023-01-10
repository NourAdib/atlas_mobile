import 'package:atlas_mobile/utility/shared_preferences.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;

  done() {
    SharedPreferencesService.setInShared('onboarding', 'done');
    Get.offNamed('/registrationOrLogin');
  }
}
