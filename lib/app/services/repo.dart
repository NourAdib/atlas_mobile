//The class used to interact with the
import 'package:atlas_mobile/app/utility/global.dart';

class Repo {
  static const String url = "http://192.168.1.175:3000";

  static const String loginPath = "/auth/login";
  static const String registerPath = "/auth/signup";
  static const String notificationRegistrationPath = "/notification/signup";
  static const String feedPath = "/feed";
  static const String userProfile = "/user/profile";
  static const String userPosts = "/post/user-posts";
  static const String userScrapbooks = "/post/scrapbook/user-scrapbooks";
  static const String like = "/post/like";
  static const String unlike = "/post/unlike";
  static const String comment = "/post/comment";
  static const String reportPost = "/report/report-post";
  static const String postById = "/post";
  static const String notificationPreference = "/user/notification-preferences";
  static const String subscribe = "/payment/subscribe";
  static const String unsubscribe = "/payment/unsubscribe";
  static const String updatePassword = "/user/password";
  static const String updateEmail = "/user/email";
  static const String updateDOB = "/user/dateOfBirth";
  static const String updateGender = "/user/gender";
  static const String updateRole = "/user/role";
  static const String deleteUser = "/user/delete";

  static var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };
}
