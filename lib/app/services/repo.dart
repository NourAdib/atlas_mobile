//The class used to interact with the
import 'package:atlas_mobile/app/utility/global.dart';

class Repo {
  static const String url = "http://192.168.1.175:3000";

  static const String loginPath = "/auth/login";
  static const String registerPath = "/auth/signup";

  static var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };
}
