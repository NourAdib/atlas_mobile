//The class used to interact with the
import 'package:atlas_mobile/app/utility/global.dart';

class Repo {
  static const String url = "http://10.6.130.39:3000";

  static const String loginPath = "/auth/login";
  static const String registerPath = "/auth/signup";
  static const String notificationRegistrationPath = "/notification/signup";
  static const String feedPath = "/feed";
  static const String userProfile = "/user/profile";
  static const String userPosts = "/post/user-posts";
  static const String memoriesPath = "/memory/proximity-memories";
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
  static const String searchUser = "/user/search";
  static const String userById = "/user/profile";
  static const String followingsPosts = "/post/following-scraps";
  static const String followingsScrapbooks = "/post/following-scrapbooks";
  static const String requestFollow = "/follow/request-follow";
  static const String acceptFollow = "/follow/accept-follow";
  static const String rejectFollow = "/follow/reject-follow";
  static const String unfollow = "/follow/unfollow";
  static const String getFollowers = "/follow/followers";
  static const String getFollowing = "/follow/following";
  static const String getFollowRequestsReceived =
      "/follow/follow-requests-received";
  static const String getFollowRequestsSent = "/follow/follow-requests-sent";
  static const String reportUser = "/report/report-user";
  static const String blockUser = "/block/block-user";
  static const String unblockUser = "/block/unblock-user";
  static const String updateBio = "/user/bio";
  static const String updateUsername = "/user/username";
  static const String updateAvatar = "/user/avatar";
  static const String deleteAvatar = "/user/avatar";
  static const String postAvatar = "/user/avatar";
  static const String scrapbook = "/post/scrapbook";
  static const String postReports = "/report/post-reports";
  static const String appealPost = "/appeals/appeal-post";
  static const String getUserAppeals = "/appeals/user-appeals";

  static var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };
}
