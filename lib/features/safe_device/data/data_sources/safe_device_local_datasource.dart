import 'dart:io';

import 'package:flutter_root_jailbreak/flutter_root_jailbreak.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/is_safe_device_params.dart';
import '../models/is_safe_device_response.dart';

abstract class SafeDeviceLocalDataSource {
  Future<IsSafeDeviceResponse> isSafeDevice(IsSafeDeviceParams params);
}

class SafeDeviceLocalDataSourceImpl implements SafeDeviceLocalDataSource {
  SafeDeviceLocalDataSourceImpl();

  @override
  Future<IsSafeDeviceResponse> isSafeDevice(IsSafeDeviceParams params) async {
    try {
      late final IsSafeDeviceResponse res;
      if (Platform.isAndroid) {
        res = IsSafeDeviceResponse(await FlutterRootJailbreak.isRooted,
            isAndroid: true);
      } else if (Platform.isIOS) {
        res = IsSafeDeviceResponse(await FlutterRootJailbreak.isJailBroken,
            isIOS: true);
      } else {
        throw Exception('Platform not supported');
      }
      return res;
    } catch (e) {
      throw AppException(
          message: "Platform Exception",
          type: ExceptionType.normal,
          data: e.toString(),
          stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
}
