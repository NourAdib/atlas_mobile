import 'dart:developer';
import 'package:get/get.dart';

class MapsScreenController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;

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
}
