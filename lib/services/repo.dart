import 'package:atlas_mobile/utility/global.dart';

//The class used to interact with the
class Repo {
  static const String url = "http://192.168.1.175:3000";

  static const String loginPath = "/auth/login";

  static var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };
}
