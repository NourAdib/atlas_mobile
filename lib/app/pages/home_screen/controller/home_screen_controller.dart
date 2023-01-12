import 'dart:developer';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var selectedIndex = 0.obs;

  onItemTap(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        log('Maps Screen');
        Get.toNamed('/maps');
        break;
      case 1:
        log('Search Screen');
        break;
      case 2:
        log('Home Screen');
        break;
      case 3:
        log('New Post Screen');
        break;
      case 4:
        log('Profile Screen');
        break;
      default:
        log('Home Screen');
    }
  }

  logout() {
    SharedPreferencesService.setInShared('accessToken', '');
    SnackBarService.showSuccessSnackbar('Success', 'Logout successful');
    Get.offNamed('/registrationOrLogin');
  }
}
