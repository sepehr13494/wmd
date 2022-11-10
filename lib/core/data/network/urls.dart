import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  AppUrls._();

  static const int wrongTokenCode = 401;
  static String baseUrl = dotenv.env['BASE_URL']!;
  static const String refreshUrl = "";

  // Base Paths
  static String baseAuth = dotenv.env['BASE_URL_AUTH']!;
  static String baseUser = dotenv.env['BASE_URL_USER']!;

  //other urls
  static String registerUser = "${baseAuth}client/sign-up";
  static String resendEmail = "${baseAuth}send-verification-email";
  static String loginUser = "${baseAuth}client/token";
  static String verifyEmail = "${baseAuth}verify-email";
  static String forgetPassword = "${baseAuth}client/reset-password";
  static String getUserStatus = "${baseUser}user";
  static String getUserNetWorth = "${baseUser}Wealth/totalnetworth";
}
