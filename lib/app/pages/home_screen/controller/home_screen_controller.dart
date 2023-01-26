import 'dart:developer';
import 'package:atlas_mobile/app/services/feed/feed.service.dart';
import 'package:atlas_mobile/app/utility/global.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/utility/snackbar.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HomeScreenController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getFeed();
  }

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

  getFeed() async {
    final dio = Dio(); // Provide a dio instance
    final feedService = FeedService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    feedService.getFeed('Bearer ${accessToken}').then((response) {
      log(response.posts![0].toString());
    }).catchError((error) {
      log(error.toString());
    });
  }

  logout() {
    SharedPreferencesService.setInShared('accessToken', '');
    SnackBarService.showSuccessSnackbar('Success', 'Logout successful');
    Get.offNamed('/registrationOrLogin');
  }
}
