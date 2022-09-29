import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:wmd/core/data/network/error_handler_middleware.dart';
import 'package:wmd/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:wmd/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:wmd/features/authentication/domain/repositories/auth_repository.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';
import 'core/data/network/network_helper.dart';
import 'core/data/network/server_request_manager.dart';
import 'core/util/app_localization.dart';
import 'core/util/app_theme.dart';
import 'core/util/device_info.dart';
import 'core/util/local_storage.dart';
import 'features/splash/data/repositories/splash_repository_impl.dart';
import 'features/splash/domain/repositories/splash_repository.dart';
import 'features/splash/domain/use_cases/check_login_usecase.dart';
import 'features/splash/presentation/manager/splash_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //repository_and_cubits
  // Splash dependency
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerLazySingleton(() => CheckLoginUseCase(sl()));
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));

  //Authentication dependency
  sl.registerFactory(() => AuthenticationCubit(sl(), sl()));
  sl.registerLazySingleton(() => PostLoginUseCase(sl()));
  sl.registerLazySingleton(() => PostRegisterUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  //local_storage
  sl.registerLazySingleton<LocalStorage>(() => LocalStorage(sl()));
  sl.registerLazySingleton<ServerRequestManager>(
      () => ServerRequestManager(sl()));
  sl.registerLazySingleton<ErrorHandlerMiddleware>(
      () => ErrorHandlerMiddleware(sl()));
  //device_info
  sl.registerLazySingleton<AppDeviceInfo>(() => AppDeviceInfo(sl()));
  //theme_manager
  sl.registerFactory(() => ThemeManager(sl()));
  //localization_manager
  sl.registerFactory(() => LocalizationManager(sl()));

  await initExternal();
}

Future<void> initExternal() async {
  sl.registerFactory<Dio>(() => NetworkHelper(sl()).getDio());

  sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  final Box authBox = await Hive.openBox("auth");
  sl.registerLazySingleton<Box>(() => authBox);
}
