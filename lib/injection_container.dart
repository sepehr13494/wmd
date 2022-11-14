import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:wmd/core/data/network/error_handler_middleware.dart';
import 'package:wmd/features/authentication/forget_password/data/data_sources/forget_password_server_datasource.dart';
import 'package:wmd/features/authentication/forget_password/data/repositories/forget_password_repository_impl.dart';
import 'package:wmd/features/authentication/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/forget_password_usecase.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/reset_password_usecase.dart';
import 'package:wmd/features/authentication/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:wmd/features/authentication/login_signup/data/data_sources/login_sign_up_remote_data_source.dart';
import 'package:wmd/features/authentication/login_signup/data/repositories/login_sign_up_repository_impl.dart';
import 'package:wmd/features/authentication/login_signup/domain/repositories/login_sign_up_repository.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/resend_email_usecase.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/verify_email/data/data_sources/verify_email_server_datasource.dart';
import 'package:wmd/features/authentication/verify_email/data/repositories/verify_email_repository_impl.dart';
import 'package:wmd/features/authentication/verify_email/domain/repositories/verify_email_repository.dart';
import 'package:wmd/features/authentication/verify_email/domain/use_cases/verify_email_usecase.dart';
import 'package:wmd/features/authentication/verify_email/presentation/manager/verify_email_cubit.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/repositories/user_status_respository_impl.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/user_status_repository.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/put_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
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
  // login and sign up
  sl.registerFactory(() => LoginSignUpCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => PostLoginUseCase(sl()));
  sl.registerLazySingleton(() => PostRegisterUseCase(sl()));
  sl.registerLazySingleton(() => ResendEmailUseCase(sl()));

  sl.registerLazySingleton<LoginSignUpRepository>(
      () => LoginSignUpRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<LoginSignUpRemoteDataSource>(
      () => LoginSignUpRemoteDataSourceImpl(sl()));

  // verifyEmail
  sl.registerFactory(() => VerifyEmailCubit(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton<VerifyEmailRepository>(
      () => VerifyEmailRepositoryImpl(sl()));
  sl.registerLazySingleton<VerifyEmailServerDataSource>(
      () => VerifyEmailServerDataSourceImpl(sl()));

  // verifyEmail
  sl.registerFactory(() => ForgetPasswordCubit(sl(), sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton<ForgetPasswordRepository>(
      () => ForgetPasswordRepositoryImpl(sl()));
  sl.registerLazySingleton<ForgetPasswordServerDataSource>(
      () => ForgetPasswordServerDataSourceImpl(sl()));

  // Dashboard - user status dependencies
  sl.registerFactory(() => UserStatusCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetUserStatusUseCase(sl()));
  sl.registerLazySingleton(() => PutUserStatusUseCase(sl()));
  sl.registerLazySingleton<UserStatusRepository>(
      () => UserStatusRepositoryImpl(sl()));
  sl.registerLazySingleton<UserStatusRemoteDataSource>(
      () => UserStatusRemoteDataSourceImpl(sl()));
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
