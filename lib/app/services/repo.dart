//The class used to interact with the
import 'package:atlas_mobile/app/utility/global.dart';

class Repo {
  static const String url = "http://10.6.208.12:3000";

  static const String loginPath = "/auth/login";
  static const String registerPath = "/auth/signup";
  static const String notificationRegisterationPath = "/notification/signup";
  static const String feedPath = "/feed";
  static const String userProfile = "/user/profile";

  static var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };
}
