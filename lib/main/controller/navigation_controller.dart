import 'dart:developer';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;

  var selectedIndex = 2.obs;

  onItemTap(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/maps');
        break;
      case 1:
        Get.toNamed('/userSearch');
        break;
      case 2:
        Get.toNamed('/home');
        break;
      case 3:
        Get.toNamed('/new_post');
        break;
      case 4:
        Get.toNamed('/profile');
        break;
      default:
        Get.toNamed('/home');
    }
  }
}
