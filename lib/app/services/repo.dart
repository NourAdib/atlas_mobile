//The class used to interact with the
import 'package:atlas_mobile/app/utility/global.dart';

class Repo {
  static const String url = "http://192.168.0.198:3000";

  static const String loginPath = "/auth/login";
  static const String registerPath = "/auth/signup";
  static const String notificationRegisterationPath = "/notification/signup";
  static const String feedPath = "/feed";
  static const String userProfile = "/user/profile";
  static const String userPosts = "/post/user-posts";

  static var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };
}
