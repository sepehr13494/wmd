import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:wmd/core/network/network_helper.dart';
import 'package:wmd/core/network/server_request_manager.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/core/util/local_storage.dart';

final sl = GetIt.instance;

Future<void> init() async{


  //repository

  //local_storage
  sl.registerLazySingleton<LocalStorage>(() => LocalStorage(sl()));
  sl.registerLazySingleton<ServerRequestManager>(() => ServerRequestManager(sl()));
  //device_info
  sl.registerLazySingleton<AppDeviceInfo>(() => AppDeviceInfo(sl()));

  await initExternal();
}

Future<void> initExternal() async {

  sl.registerFactory<Dio>(() => NetworkHelper(sl()).getDio());

  sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  final Box authBox = await Hive.openBox("auth");
  sl.registerLazySingleton<Box>(() => authBox);


}