import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //Get the width of the screen
  var width = Get.width;

  //When the controller is initialized, call the _navigateToHome method
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  //Wait for 3 seconds and then navigate to the registration 1page
  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});

    if (!(await SharedPreferencesService.getIsOnboardingDone())) {
      Get.offNamed('/onboarding');
      return;
    }

    if (await SharedPreferencesService.getIsLoggedIn()) {
      Get.offNamed('/home');
      return;
    }

    //Navigate to the registration page and do not allow the user to return to the splash screen
    Get.offNamed('/registrationOrLogin');
  }
}
