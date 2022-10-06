import '../../release_setting.dart';

class PlatformManager {
  static getAppSource() {
    switch (appReleaseType) {
      case AppReleaseType.googlePlay:
        return "1";
      case AppReleaseType.apk:
        return "2";
      case AppReleaseType.appBazaar:
        return "3";
      case AppReleaseType.webApp:
        return "4";
      case AppReleaseType.website:
        return "5";
      case AppReleaseType.adminPanel:
        return "6";
      case AppReleaseType.ios:
        return "7";
        break;
    }
  }
}
