import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart';

class AppDeviceInfoModel {
  final String deviceName;
  final String osVersion;
  final String deviceId;
  final String os;
  final String ip;

  AppDeviceInfoModel({
    required this.deviceName,
    required this.osVersion,
    required this.deviceId,
    required this.os,
    required this.ip,
  });
}

class AppDeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin;

  static final tAppDeviceInfo = AppDeviceInfoModel(
    deviceName: 'test',
    osVersion: 'test',
    deviceId: 'test',
    ip: 'test',
    os: 'test',
  );

  AppDeviceInfo(this.deviceInfoPlugin);

  Future<AppDeviceInfoModel> getDeviceInfo() async {
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;

      debugPrint('Running on ${webBrowserInfo.userAgent}');
      return AppDeviceInfoModel(
          deviceName: webBrowserInfo.browserName.name,
          osVersion: webBrowserInfo.appVersion ?? "0",
          deviceId: webBrowserInfo.userAgent ?? "No Data",
          ip: 'webdummyip',
          os: webBrowserInfo.platform.toString());
    } else {
      String networkInfo = await NetworkInfo().getWifiIP() ?? "IP not detected";
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        debugPrint('Running on ${androidInfo.model}');
        return AppDeviceInfoModel(
            deviceName: androidInfo.model ?? "No Data",
            osVersion: androidInfo.version.release ?? "0",
            deviceId: androidInfo.id ?? "No Data",
            ip: networkInfo,
            os: "Android");
      } else {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        debugPrint('Running on ${iosInfo.utsname.machine}');
        return AppDeviceInfoModel(
            deviceName: iosInfo.utsname.machine ?? "No Data",
            osVersion: iosInfo.utsname.version ?? "0",
            deviceId: iosInfo.identifierForVendor ?? "No Data",
            ip: networkInfo,
            os: "iOS");
      }
    }
  }
}
