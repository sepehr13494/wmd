import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class AppDeviceInfoModel {
  final String deviceName;
  final String osVersion;
  final String deviceId;
  final String os;

  AppDeviceInfoModel({
    required this.deviceName,
    required this.osVersion,
    required this.deviceId,
    required this.os,
  });
}

class AppDeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin;

  AppDeviceInfo(this.deviceInfoPlugin);

  Future<AppDeviceInfoModel> getDeviceInfo() async {
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
      debugPrint('Running on ${webBrowserInfo.userAgent}');
      return AppDeviceInfoModel(
          deviceName: webBrowserInfo.browserName.name,
          osVersion: webBrowserInfo.appVersion ?? "0",
          deviceId: webBrowserInfo.userAgent ?? "No Data",
          os: webBrowserInfo.platform.toString());
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        debugPrint('Running on ${androidInfo.model}');
        return AppDeviceInfoModel(
            deviceName: androidInfo.model ?? "No Data",
            osVersion: androidInfo.version.release ?? "0",
            deviceId: androidInfo.id ?? "No Data",
            os: "Android");
      } else {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        debugPrint('Running on ${iosInfo.utsname.machine}');
        return AppDeviceInfoModel(
            deviceName: iosInfo.utsname.machine ?? "No Data",
            osVersion: iosInfo.utsname.version ?? "0",
            deviceId: iosInfo.identifierForVendor ?? "No Data",
            os: "iOS");
      }
    }
  }
}
