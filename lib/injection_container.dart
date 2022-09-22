import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:wmd/core/data/network/network_helper.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/presentation/routes/app_router.gr.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:wmd/features/splash/domain/repositories/splash_repository.dart';
import 'package:wmd/features/splash/domain/use_cases/check_login_usecase.dart';
import 'package:wmd/features/splash/presentation/manager/splash_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async{


  //repository_and_cubits
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerLazySingleton(() => CheckLoginUseCase(sl()));
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));

  //local_storage
  sl.registerLazySingleton<LocalStorage>(() => LocalStorage(sl()));
  sl.registerLazySingleton<ServerRequestManager>(() => ServerRequestManager(sl()));
  //device_info
  sl.registerLazySingleton<AppDeviceInfo>(() => AppDeviceInfo(sl()));
  //theme_manager
  sl.registerFactory(() => ThemeManager(sl()));
  //localization_manager
  sl.registerFactory(() => LocalizationManager(sl()));
  //app_router
  sl.registerSingleton<AppRouter>(AppRouter());

  await initExternal();
}

Future<void> initExternal() async {

  sl.registerFactory<Dio>(() => NetworkHelper(sl()).getDio());

  sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  final Box authBox = await Hive.openBox("auth");
  sl.registerLazySingleton<Box>(() => authBox);


}