import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage{
  final Box authBox;

  LocalStorage(this.authBox);

  Future<void> setTokenAndLogin(token) async {
    authBox.put("token", "Bearer $token");
    authBox.put("isLogin", true);
  }

  Future<void> logout() async {
    authBox.clear();
  }

  Future<String> getToken() async{
    return authBox.get("token",defaultValue: "");
  }

  Future<bool> getLogin() async{
    return authBox.get("isLogin",defaultValue: false);
  }
}