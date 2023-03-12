import 'package:get/get.dart';

class TopBarController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;

  goToSettingsPage() {
    /* SharedPreferencesService.setInShared('accessToken', '');
    SnackBarService.showSuccessSnackbar('Success', 'Logout successful');
    Get.offNamed('/registrationOrLogin'); */
    Get.toNamed("/settings");
  }
}
