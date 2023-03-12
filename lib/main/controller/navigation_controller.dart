import 'dart:developer';
import 'package:atlas_mobile/app/pages/maps_screen/controller/ar_screen_controller.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  //Get controller for AR screen
  final ArScreenController arC = Get.put(ArScreenController());

  //Get the width of the screen
  var width = Get.width;

  //Get the height of the screen
  var height = Get.height;

  var selectedIndex = 2.obs;

  onItemTap(int index) {
    arC.exitAR();
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
